{ pkgs, ... }:

{
  # define user account
  users.users.ponymushama = {
    isNormalUser = true;
    description = "ponymushama";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  users = {
    mutableUsers = true;
  };

  # default system packages
  environment.systemPackages = with pkgs;[
    git
    vim
    wget
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
  };

  # # flatpak
  # systemd.services.flatpak-repo = {
  #   path = [ pkgs.flatpak ];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };

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
