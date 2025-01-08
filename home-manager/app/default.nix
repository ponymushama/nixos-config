{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs;[
    firefox
    obsidian
    mihomo-party
    spotify
    _1password-gui
    _1password-cli
    kate
    catppuccin-kde      # kate theme
    telegram-desktop
  ];
}
