-- WezTerm Configuration
-- Managed by Chezmoi
-- Tokyo Night theme

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ─────────────────────────────────────────────────────────────────────────────
-- Appearance
-- ─────────────────────────────────────────────────────────────────────────────

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' })
config.font_size = 14.0
config.line_height = 1.2

-- Window
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- Cursor
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- ─────────────────────────────────────────────────────────────────────────────
-- Performance
-- ─────────────────────────────────────────────────────────────────────────────

config.max_fps = 120
config.animation_fps = 60
config.front_end = 'WebGpu'

-- ─────────────────────────────────────────────────────────────────────────────
-- Behavior
-- ─────────────────────────────────────────────────────────────────────────────

config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false

-- macOS specific
config.native_macos_fullscreen_mode = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- ─────────────────────────────────────────────────────────────────────────────
-- Key Bindings
-- ─────────────────────────────────────────────────────────────────────────────

config.keys = {
  -- Split panes
  { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Navigate panes
  { key = '[', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Prev' },
  { key = ']', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Next' },
  { key = 'h', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

  -- Close pane
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = true } },

  -- Tabs
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'LeftArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(1) },

  -- Font size
  { key = '=', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },

  -- Quick select mode (like tmux copy mode)
  { key = 'f', mods = 'CMD|SHIFT', action = wezterm.action.QuickSelect },

  -- Command palette
  { key = 'p', mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette },
}

-- ─────────────────────────────────────────────────────────────────────────────
-- Tokyo Night Colors (custom overrides)
-- ─────────────────────────────────────────────────────────────────────────────

config.colors = {
  tab_bar = {
    background = '#1a1b26',
    active_tab = {
      bg_color = '#7aa2f7',
      fg_color = '#1a1b26',
    },
    inactive_tab = {
      bg_color = '#24283b',
      fg_color = '#565f89',
    },
    inactive_tab_hover = {
      bg_color = '#33467c',
      fg_color = '#c0caf5',
    },
  },
}

return config
