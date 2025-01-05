{ config, pkgs, inputs, ... }:

{
  imports = [
    ./fish.nix
    ./wezterm.nix
    ./cli.nix
    ./yazi.nix
  ];
}
