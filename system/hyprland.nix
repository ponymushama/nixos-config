{ pkgs, ... }:

let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );
in

{
  # system packages
  environment.systemPackages = (with pkgs; [
    baobab
    bc
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    ffmpeg
    glib #for gsettings to work
    gsettings-qt
    killall
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    xdg-user-dirs
    xdg-utils
    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray

    # Hyprland Stuff
    ags # note: defined at flake.nix to download and install ags v3
    btop
    brightnessctl # for brightness control
    cava
    cliphist
    eog
    gnome-system-monitor
    grim
    gtk-engine-murrine #for gtk themes
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    imagemagick
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum #kvantum
    networkmanagerapplet
    nwg-look # requires unstable channel
    nvtopPackages.panthor
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum #kvantum
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    wallust
    wlogout
    xarchiver
    yad
    yt-dlp
    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];

  # hyprland
  programs = {
	  hyprland = {
      enable = true;
		  #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		  portalPackage = pkgs.xdg-desktop-portal-hyprland;
  	  xwayland.enable = true;
      };
	
	  waybar.enable = true;
	  hyprlock.enable = true;
    nm-applet.indicator = true;

	  thunar.enable = true;
	  thunar.plugins = with pkgs.xfce; [
		  exo
		  mousepad
		  thunar-archive-plugin
		  thunar-volman
		  tumbler
  	  ];
	
    virt-manager.enable = false;
 
    xwayland.enable = true;

    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
