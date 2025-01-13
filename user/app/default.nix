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
    wechat-uos
    notepad-next
    qq
    vlc
    discord
    zathura
    libreoffice
    zotero
  ];
  programs.qutebrowser.enable = true;
  services.dropbox.enable = true;
}
