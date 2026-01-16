local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")
local keys = require("keymaps")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ==============================
-- Basic settings
-- ==============================

-- Launch with WSL (Ubuntu)
config.default_domain = 'WSL:Ubuntu'

-- Faster rendering
config.front_end = "WebGpu"
config.max_fps = 60
config.animation_fps = 60

-- TUI optimization
config.scrollback_lines = 5000
config.enable_scroll_bar = false

-- Configuration for Claude Code
config.use_ime = false

-- Appearance
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "TITLE | RESIZE"
config.color_scheme = "Kanagawa Dragon (Gogh)"
config.window_background_opacity = 0.9

-- Fonts
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13

-- ==============================
-- Keybinding settings
-- ==============================
config.leader = {
  key = "x",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

config.keys = keys

return config
