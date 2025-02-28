{ config, pkgs, inputs, ... }:

{
  # modules
  imports = [
    ./shell
    ./fcitx5
    ./nvim
    ./gnome
    ./app
  ];

  home.username = "ponymushama";
  home.homeDirectory = "/home/ponymushama";

  # env variables
  home = {
    sessionVariables = {
      QT_IM_MODULE = "fcitx";
      GTK_IM_MODULE = "fcitx";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Numix-Cursor-Light";
      GDK_SCALE = "1";
      QT_SCALE_FACTOR = "1";
    };
  };

  # # cursor DPI 4K
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  home.packages = with pkgs;[
    # fonts
    sarasa-gothic
    lxgw-wenkai
    lxgw-wenkai-screen
    lxgw-neoxihei
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
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
