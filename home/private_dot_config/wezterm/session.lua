local wezterm = require('wezterm')

local M = {}

local session_file = wezterm.home_dir .. '/.wezterm-session.json'
local last_save_time = 0
local SAVE_THROTTLE = 5
local startup_time = os.time()
local STARTUP_GRACE = 10

-- Save current tab state (called periodically from update-status)
function M.save(window)
  local now = os.time()
  -- Don't save right after startup (wait for restore to finish)
  if now - startup_time < STARTUP_GRACE then
    return
  end
  -- Throttle saves
  if now - last_save_time < SAVE_THROTTLE then
    return
  end
  last_save_time = now

  local mux_win = window:mux_window()
  local active_tab_id = mux_win:active_tab():tab_id()
  local tabs = {}

  for _, tab in ipairs(mux_win:tabs()) do
    local pane = tab:active_pane()
    local cwd = pane:get_current_working_dir()
    if cwd then
      table.insert(tabs, {
        cwd = cwd.file_path,
        is_active = (tab:tab_id() == active_tab_id),
      })
    end
  end

  if #tabs > 0 then
    local f = io.open(session_file, 'w')
    if f then
      f:write(wezterm.json_encode(tabs))
      f:close()
    end
  end
end

-- Startup: maximize window + restore previous session
function M.startup(cmd)
  local mux = wezterm.mux
  local tabs = nil

  -- Try to load saved session
  local f = io.open(session_file, 'r')
  if f then
    local data = f:read('*a')
    f:close()
    local ok, parsed = pcall(wezterm.json_parse, data)
    if ok and type(parsed) == 'table' and #parsed > 0 then
      tabs = parsed
    end
  end

  -- Spawn first window
  local first_cwd = tabs and tabs[1] and tabs[1].cwd
  local tab, pane, window
  if first_cwd then
    tab, pane, window = mux.spawn_window({ cwd = first_cwd })
  else
    tab, pane, window = mux.spawn_window(cmd or {})
  end

  -- Restore remaining tabs
  if tabs then
    local active_idx = 1
    for i = 2, #tabs do
      if tabs[i].cwd then
        window:spawn_tab({ cwd = tabs[i].cwd })
      end
    end
    -- Find previously active tab
    for i, t in ipairs(tabs) do
      if t.is_active then
        active_idx = i
        break
      end
    end
    local all_tabs = window:tabs()
    if active_idx >= 1 and active_idx <= #all_tabs then
      all_tabs[active_idx]:activate()
    end
  end

  -- Maximize window
  window:gui_window():maximize()
end

return M
