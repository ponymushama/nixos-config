{ pkgs, ... }:

{
  # GNOME settings
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager = {
        gnome.enable = true;
      };
      xkb = {
        layout = "us";
        variant = "";
        options = "ctrl:nocaps";
      };
    };
    gnome.gnome-keyring.enable = true;
  };

  programs.dconf.enable = true;
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    font-name='LXGW Wenkai Screen 12'
    document-font-name='LXGW Wenkai Screen 12'
    monospace-font-name='JetBrainsMono Nerd Font Mono 12'
  '';

  # delete GNOME default app
  environment.gnome.excludePackages = with pkgs; [
    gnome-music
    gnome-terminal
    gedit
    epiphany
    geary
    gnome-characters
    totem
    gnome-weather
    gnome-contacts
    gnome-maps
    gnome-connections
    gnome-photos
    yelp
    evince
  ];

  # make keymap config same between x11 & console & wayland
  console.useXkbConfig = true;
}