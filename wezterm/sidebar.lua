-- wezterm-claude-sidebar / lua glue
--
-- Drop this file somewhere on WezTerm's lua package path (or symlink into
-- `~/.config/wezterm`) and in your `wezterm.lua`:
--
--     local sidebar = require("sidebar")
--     sidebar.apply(config, {
--       binary = "wcs",                        -- or absolute path
--       toggle_key = { key = "s", mods = "LEADER" },
--       width_cells = 42,
--       tab_title = true,                      -- also enhance tab titles
--     })
--
-- The toggle opens a left split running `wcs` in the current tab. Pressing
-- the same binding again (or `q` inside the sidebar) closes it.

local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

-- The sidebar identifies itself by setting its pane title. We locate
-- the existing sidebar (if any) by scanning the current tab for a pane
-- with this title.
local SIDEBAR_TITLE = "wcs-sidebar"

-- ---------------------------------------------------------------------------
-- Tab title formatter: turn the generic "✳ Claude Code" into something like
-- "joyfit ● main*". Only engages when the tab looks like it's running
-- Claude Code; otherwise defers to the default title.
-- ---------------------------------------------------------------------------

local function basename(p)
  if not p or p == "" then
    return ""
  end
  return p:match("([^/]+)$") or p
end

local function cwd_from_pane(pane)
  local uri = pane.current_working_dir
  if not uri then
    return nil
  end
  -- wezterm gives either a string or a Url userdata depending on version
  if type(uri) == "string" then
    return uri:match("^file://[^/]*(/.*)$")
  end
  if uri.file_path then
    return uri.file_path
  end
  return nil
end

-- Pick the best short label for a tab: prefer the cwd basename
-- (which is usually a project name), fall back to the pane title.
-- Claude Code rewrites the pane title to the current user-message
-- snippet, so title-matching is unreliable — cwd is stable.
function M.format_tab_title(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local cwd = cwd_from_pane(pane)
  local name = basename(cwd)
  if not name or name == "" then
    name = pane.title or ""
  end

  local text = string.format(" %d %s ", tab.tab_index + 1, name)
  -- Use lua string length; for non-ASCII project names this is
  -- pessimistic but safe (errs toward fitting).
  if #text > max_width then
    text = text:sub(1, max_width - 1) .. "…"
  end
  return text
end

-- ---------------------------------------------------------------------------
-- Sidebar toggle action.
-- ---------------------------------------------------------------------------

-- Find the sidebar pane in the currently-active tab, or nil if none.
local function find_sidebar_in_current_tab(window)
  local tab = window:active_tab()
  if not tab then
    return nil
  end
  for _, p in ipairs(tab:panes()) do
    if p:get_title() == SIDEBAR_TITLE then
      return p
    end
  end
  return nil
end

local function toggle_sidebar(binary, width)
  return wezterm.action_callback(function(window, pane)
    local existing = find_sidebar_in_current_tab(window)
    if existing then
      wezterm.run_child_process({
        "wezterm.exe", "cli", "kill-pane",
        "--pane-id", tostring(existing:pane_id()),
      })
      return
    end

    -- pane:split's `size` wants a 0..1 fraction of the parent pane,
    -- so convert our desired cell count into a ratio using the parent
    -- pane's current dimensions.
    local dims = pane:get_dimensions()
    local parent_cols = (dims and dims.cols) or 160
    local ratio = width / parent_cols
    if ratio < 0.1 then ratio = 0.1 end
    if ratio > 0.5 then ratio = 0.5 end

    -- On WSL the WEZTERM_PANE env var doesn't propagate through the
    -- Windows → WSL interop layer, so we pass the host pane and tab
    -- ids explicitly. wcs uses them to route wezterm cli commands
    -- back to the right window and to seed the cursor on the tab
    -- the user was on when they opened the sidebar.
    local host_pane_id = pane:pane_id()
    local host_tab = window:active_tab()
    local host_tab_id = host_tab and host_tab:tab_id() or -1

    local new_pane = pane:split({
      direction = "Left",
      size = ratio,
      args = {
        binary,
        "--host-pane", tostring(host_pane_id),
        "--host-tab", tostring(host_tab_id),
      },
    })

    -- WSL can't propagate WEZTERM_PANE to the spawned process, so we
    -- hand the new pane id to wcs via a tiny handshake file keyed on
    -- the host pane id. wcs polls for it at startup and uses it to
    -- self-identify (for the self-exclude filter and to auto-close
    -- the sidebar on tab jump).
    if new_pane then
      local path = "/tmp/wcs-pane-" .. tostring(host_pane_id)
      local f = io.open(path, "w")
      if f then
        f:write(tostring(new_pane:pane_id()))
        f:close()
      end
    end
  end)
end

-- ---------------------------------------------------------------------------
-- Apply the sidebar integration to a wezterm config table.
-- ---------------------------------------------------------------------------

function M.apply(config, opts)
  opts = opts or {}
  local binary = opts.binary or "wcs"
  local width = opts.width_cells or 42
  local toggle = opts.toggle_key or { key = "s", mods = "LEADER" }

  config.keys = config.keys or {}
  table.insert(config.keys, {
    key = toggle.key,
    mods = toggle.mods,
    action = toggle_sidebar(binary, width),
  })

  -- Give each tab enough room for "N project-name" without
  -- truncation in the common case.
  if opts.tab_max_width ~= false then
    config.tab_max_width = opts.tab_max_width or 22
  end

  if opts.tab_title ~= false then
    wezterm.on("format-tab-title", M.format_tab_title)
  end
end

return M
