{ ... }:

{
  # services
  services = {
    smartd = {
      enable = false;
      autodetect = true;
    };
 
	  gvfs.enable = true;
	  tumbler.enable = true;

	  pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
	    wireplumber.enable = true;
  	  };
	
    pulseaudio.enable = false; #unstable
	  udev.enable = true;
	  envfs.enable = true;
	  dbus.enable = true;

	  fstrim = {
      enable = true;
      interval = "weekly";
      };
 
    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;
 
    openssh.enable = true;
    flatpak.enable = false;
	
  	blueman.enable = true;
 
  	# hardware.openrgb.enable = true;
  	# hardware.openrgb.motherboard = "amd";

	  fwupd.enable = true;

	  upower.enable = true;
 
    printing = {
      enable = false;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
 
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };
 
    # ipp-usb.enable = true;
 
    # syncthing = {
    #   enable = false;
    #   user = "${username}";
    #   dataDir = "/home/${username}";
    #   configDir = "/home/${username}/.config/syncthing";
    # };
  };
}
