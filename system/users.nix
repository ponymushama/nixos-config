{ pkgs, ... }:

{
  # define user account
  users.users.ponymushama = {
    isNormalUser = true;
    description = "ponymushama";
    # add i2c
    extraGroups = [ "networkmanager" "wheel" "i2c" ];
  };
  users = {
    mutableUsers = true;
  };

  # i2c LG UltraFine
  users.groups.i2c = {};
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # default system packages
  environment.systemPackages = with pkgs;[
    git
    vim
    wget
    ddcutil        # LG UltraFine
  ];

  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  # default shell = fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # variables
  environment.sessionVariables = {
    # For Electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # default terminal
    TERMINAL = "wezterm";
    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Numix-Cursor-Light";
    GDK_SCALE = "1";
    QT_SCALE_FACTOR = "1";
  };

  # flatpak
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # # sudo $HOME
  # security.sudo.extraConfig = ''
  #   Defaults env_keep += "HOME XDG_CONFIG_HOME"
  # '';

  # # Virtualization / Containers
  # virtualisation.libvirtd.enable = false;
  # virtualisation.podman = {
  #   enable = false;
  #   dockerCompat = false;
  #   defaultNetwork.settings.dns_enabled = false;
  # };
}
