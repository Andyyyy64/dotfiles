local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
  -- C-x 3: Split horizontally (side by side)
  {
    key = "3",
    mods = "LEADER",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },

  -- C-x 2: Split vertically (top and bottom)
  {
    key = "2",
    mods = "LEADER",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },

  -- C-x o: Go to the next pane (similar to Emacs C-x o)
  {
    key = "o",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Next"),
  },

  -- C-x O (Shift-o): Go to the previous pane
  {
    key = "O",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Prev"),
  },

  -- C-x 0: Close current pane (without confirmation)
  {
    key = "0",
    mods = "LEADER",
    action = act.CloseCurrentPane { confirm = false },
  },

  -- C-x k: Close current pane (without confirmation)
  {
    key = "k",
    mods = "LEADER",
    action = act.CloseCurrentPane { confirm = false },
  },

  -- C-x 1: Zoom current pane instead of closing others (Emacs-like feel)
  {
    key = "1",
    mods = "LEADER",
    action = act.TogglePaneZoomState,
  },

  -- C-x b: Tab navigator (Emacs-like buffer switching)
  {
    key = "b",
    mods = "LEADER",
    action = act.ShowTabNavigator,
  },

  -- C-x r: Reload configuration (useful)
  {
    key = "r",
    mods = "LEADER",
    action = act.ReloadConfiguration,
  },

  -- M-x (Alt-x): Command palette
  {
    key = "x",
    mods = "ALT",
    action = act.ActivateCommandPalette,
  },

  -- Alt-Enter: Toggle full screen
  {
    key = "Enter",
    mods = "ALT",
    action = act.ToggleFullScreen,
  },
}

return keys
