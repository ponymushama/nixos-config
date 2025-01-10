{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      # "https://mirrors.sustech.edu.cn/nix-channels/store"
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
    trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
  };

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # hostname
  networking.hostName = "ponymushama";

  # network
  networking.networkmanager.enable = true;

  # TUN/TAP
  boot.kernelModules = [ "tun" ];
  # TUN/TAP mihomo-party
  security.wrappers.mihomo-party = {
    source = "${pkgs.mihomo-party}/bin/mihomo-party";
    capabilities = "cap_net_admin,cap_net_bind_service=+ep";
    owner = "root";
    group = "wheel";
  };

  # localization
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11
  services.xserver.enable = true;

  # GNOME desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # config keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps";
  };
  # make keymap config same between x11 & console & wayland
  console.useXkbConfig = true;

  # print
  services.printing.enable = true;

  # audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # define user account
  users.users.ponymushama = {
    isNormalUser = true;
    description = "ponymushama";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # system packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  # nix-ld
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    zstd
    stdenv.cc.cc
    curl
    openssl
    attr
    libssh
    bzip2
    libxml2
    acl
    libsodium
    util-linux
    xz
    systemd
    icu
  ];

  # sudo $HOME
  security.sudo.extraConfig = ''
    Defaults env_keep += "HOME XDG_CONFIG_HOME"
  '';

  # system fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      sarasa-gothic
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];
  };

  # GNOME dconf settings
  programs.dconf.enable = true;
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    font-name='Sarasa Mono SC 11'
    document-font-name='Sarasa Mono SC 11'
    monospace-font-name='JetBrainsMono Nerd Font Mono 11'
  '';
 
  # default shell = fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # steam
  hardware.graphics.enable32Bit = true;
  programs.steam.enable = true;

  system.stateVersion = "24.11";
}
