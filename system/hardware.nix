{ ... }:

{
  imports = [
    ../modules/amd-drivers.nix
    ../modules/nvidia-drivers.nix
    ../modules/nvidia-prime-drivers.nix
    ../modules/intel-drivers.nix
    ../modules/vm-guest-services.nix
    ../modules/local-hardware-clock.nix
  ];

  drivers.amdgpu.enable = true;
  drivers.intel.enable = false;
  drivers.nvidia.enable = false;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
    };

  powerManagement = {
  	enable = true;
	  cpuFreqGovernor = "schedutil";
  };

  # hardware.sane = {
  #   enable = true;
  #   extraBackends = [ pkgs.sane-airscan ];
  #   disabledDefaultBackends = [ "escl" ];
  # };

  # Extra Logitech Support
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Bluetooth
  hardware = {
  	bluetooth = {
	    enable = true;
	    powerOnBoot = true;
	    settings = {
		    General = {
		      Enable = "Source,Sink,Media,Socket";
		      Experimental = true;
		    };
      };
    };
  };

  # steam
  hardware.graphics.enable32Bit = true;
}
