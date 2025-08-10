{ config, pkgs, inputs, ... }:

{
  # yazi
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    flavors = {
      catppuccin-mocha = let
        src = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "fc8eeaab9da882d0e77ecb4e603b67903a94ee6e";
          hash = "sha256-wvxwK4QQ3gUOuIXpZvrzmllJLDNK6zqG5V2JAqTxjiY=";
        };
      in pkgs.runCommand "yazi-flavor-catppuccin-mocha" { } ''
        mkdir -p $out
        cp -r ${src}/catppuccin-mocha.yazi/* $out/
      '';
    };
    theme = {
      flavor = {
        dark = "catppuccin-mocha";
        light = "catppuccin-mocha";
    };
    };
  };
}
