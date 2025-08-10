{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs;[
    firefox
    google-chrome
    obsidian
    mihomo-party
    flclash
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
    qq
    drawio
  ];
  services.dropbox.enable = true;
}
