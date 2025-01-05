{ config, pkgs, inputs, ... }:

{
  # wezterm
  programs.wezterm = {
    enable = true;
    # 基础配置
    extraConfig = ''
      local wezterm = require("wezterm")
      -- max window
      local mux = wezterm.mux
      wezterm.on('gui-startup', function(cmd)
        local tab, pane, window = mux.spawn_window(cmd or {})
        window:gui_window():maximize()
      end)
      local config = {}
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end
      -- rendering
      config.front_end = "WebGpu"
      -- font
      config.font = wezterm.font_with_fallback({
        { family = "JetBrains Mono", weight = "Bold" },
        { family = "Sarasa Mono SC", weight = "Bold" },
        { family = "Symbols Nerd Font Mono", scale = 0.8 },
      })
      config.font_size = 14
      config.use_cap_height_to_scale_fallback_fonts = true
      -- colorscheme
      config.color_scheme = "Catppuccin Mocha"
      -- tab bar
      config.hide_tab_bar_if_only_one_tab = true
      config.tab_bar_at_bottom = true
      -- window
      -- 去掉顶部的窗口栏
      config.window_decorations = "RESIZE"
      -- 窗口透明
      config.window_background_opacity = 0.85
      -- 调整窗口的边框距离
      config.window_padding = {
        left = "0cell",
        right = "0cell",
        top = "0cell",
        bottom = "0cell",
      }
      -- 改变字体大小，而不改变窗口大小
      config.adjust_window_size_when_changing_font_size = false
      config.window_close_confirmation = "NeverPrompt"
      -- BG
      config.background = {
	{
	  source = {
	    File = "/home/ponymushama/Pictures/wezterm_bg_1.png",
	  },
	    hsb = {
	      hue = 1.0,
	      saturation = 1.1,
	      brightness = 0.25,
	    },
	    width = "100%",
	    height = "100%",
	},
	{
	  source = {
	    Color = "#282c35",
	  },
	    width = "100%",
            height = "100%",
            opacity = 0.4,
	},
      }
      -- cursor
      config.hide_mouse_cursor_when_typing = true
      config.xcursor_theme = "Adwaita"
      return config
    '';
  };
}
