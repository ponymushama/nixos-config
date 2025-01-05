{ config, pkgs, inputs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "ponymushama";
  home.homeDirectory = "/home/ponymushama";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # 设置鼠标指针大小以及字体 DPI（适用于 4K 显示器）
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    neovim
    tmux
    lazygit
    fastfetch

    # lazyvim
    clang-tools
    gcc
    icu
    nodejs
    xclip
    wl-clipboard

    # rime
    librime
    librime-lua

    # lang
    rustc
    cargo
    python3Full

    # archives
    zip
    xz
    unzip
    p7zip

    # fonts
    sarasa-gothic
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    # utils
    ripgrep
    eza
    fzf
    bat
    fd
    tldr
    zoxide
    done

    # gnome
    gnome-tweaks

    # misc
    which
    aria2
    catppuccin-kde

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # app
    obsidian
    mihomo-party
    spotify
    _1password-gui
    _1password-cli
    kate
  ];

  # git
  programs.git = {
    enable = true;
    userName = "ponymushama";
    userEmail = "ponymushama@gmail.com";
    extraConfig = {
      safe.directory = [
        "/etc/nixos"
      ];
    };
  };

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

  # fish
  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -gx TERM xterm-256color
    '';
    plugins = [
      # z - 目录跳转
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      # pure - 主题
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
      # done - 命令完成通知
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      # fzf.fish - fzf 集成
      {
        name = "fzf.fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
    shellAliases = {
      # eza 相关别名
      ls = "eza";                                                 # 基础替换
      ll = "eza -l --icons --git";                                # 长列表
      la = "eza -la --icons --git";                               # 包含隐藏文件
      lt = "eza --tree --icons -a -I '.git|node_modules|.next'";  # 树状显示
      l = "eza -lah --icons --git";                               # 详细信息
      lg = "eza -la --icons --git-ignore";                        # 显示 git 状态
      # 目录导航
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      # 其他实用别名
      c = "clear";                    # 清屏
      h = "history";                  # 历史记录
      sm = "sudoedit";                # edit
      ports = "netstat -tulanp";      # 查看端口占用
      path = "echo $PATH | tr ':' '\n'"; # 显示 PATH
    };
  };

    # fcitx5 rime
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        fcitx5-rime
        catppuccin-fcitx5
      ];
    };
    home.file.".config/fcitx5/config".text = ''
      [Hotkey]
      # Enumerate when press trigger key repeatedly
      EnumerateWithTriggerKeys=True
      # Temporally switch between first and current Input Method
      AltTriggerKeys=
      # Enumerate Input Method Forward
      EnumerateForwardKeys=
      # Enumerate Input Method Backward
      EnumerateBackwardKeys=
      # Skip first input method while enumerating
      EnumerateSkipFirst=False
      # Toggle embedded preedit
      TogglePreedit=

      [Hotkey/TriggerKeys]
      0=Super+comma

      [Hotkey/EnumerateGroupForwardKeys]
      0=Super+space

      [Hotkey/EnumerateGroupBackwardKeys]
      0=Shift+Super+space

      [Hotkey/ActivateKeys]
      0=Hangul_Hanja

      [Hotkey/DeactivateKeys]
      0=Hangul_Romaja

      [Hotkey/PrevPage]
      0=Up

      [Hotkey/NextPage]
      0=Down

      [Hotkey/PrevCandidate]
      0=Shift+Tab

      [Hotkey/NextCandidate]
      0=Tab

      [Behavior]
      # Active By Default
      ActiveByDefault=False
      # Reset state on Focus In
      resetStateWhenFocusIn=No
      # Share Input State
      ShareInputState=No
      # Show preedit in application
      PreeditEnabledByDefault=True
      # Show Input Method Information when switch input method
      ShowInputMethodInformation=True
      # Show Input Method Information when changing focus
      showInputMethodInformationWhenFocusIn=False
      # Show compact input method information
      CompactInputMethodInformation=True
      # Show first input method information
      ShowFirstInputMethodInformation=True
      # Default page size
      DefaultPageSize=5
      # Override Xkb Option
      OverrideXkbOption=False
      # Custom Xkb Option
      CustomXkbOption=
      # Force Enabled Addons
      EnabledAddons=
      # Force Disabled Addons
      DisabledAddons=
      # Preload input method to be used by default
      PreloadInputMethod=True
      # Allow input method in the password field
      AllowInputMethodForPassword=False
      # Show preedit text when typing password
      ShowPreeditForPassword=False
      # Interval of saving user data in minutes
      AutoSavePeriod=30
    '';

  # yazi

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    settings = {
      manager = {
        show_hidden = true;
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See

  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
