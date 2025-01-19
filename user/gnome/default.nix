{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs;[
    gnome-tweaks
    gnomeExtensions.kimpanel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.extension-list
    gnomeExtensions.arc-menu
    gnomeExtensions.background-logo
    gnomeExtensions.dash-to-dock
    gnomeExtensions.hide-top-bar
    gnomeExtensions.just-perfection
    gnomeExtensions.openweather-refined
    gnomeExtensions.appindicator
    gnomeExtensions.open-bar
    gnomeExtensions.pano
    numix-gtk-theme
    numix-cursor-theme
    numix-icon-theme-circle
    whitesur-gtk-theme
  ];
}
