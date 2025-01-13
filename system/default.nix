{ ... }:

{
  imports =
    [
      ../hardware-configuration.nix
      ./boot.nix
      ./hyprland.nix
      ./gnome.nix
      ./hardware.nix
      ./nix-ld.nix
      ./fonts.nix
      ./nix.nix
      ./network-time.nix
      ./services.nix
      ./users.nix
    ];

  system.stateVersion = "24.11";
}
