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

  # cursor DPI 4K
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

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
