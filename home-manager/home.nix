{ config, pkgs, inputs, ... }:

{
  # modules
  imports = [
    ./shell
    ./fcitx5
    ./nvim
  ];

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

  # cursor DPI for 4K
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs;[
    # fonts
    sarasa-gothic
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    # app
    obsidian
    mihomo-party
    spotify
    _1password-gui
    _1password-cli
    kate
    catppuccin-kde      # kate theme
    gnome-tweaks        # gnome theme
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

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
