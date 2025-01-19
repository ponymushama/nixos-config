{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs;[
    firefox
    obsidian
    mihomo-party
    _1password-gui
    _1password-cli
    telegram-desktop
    bottles
    vlc
    discord
    zathura
    libreoffice
    zotero
    zed-editor
  ];
  services.dropbox.enable = true;
}
