{ config, pkgs, inputs, ... }:
{
  # fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      # rime
      fcitx5-rime
      fcitx5-configtool
      fcitx5-chinese-addons
    ];
  };
  home.packages = with pkgs;[
    # rime enable lua
    librime
    librime-lua
  ];
  # fcitx5 config
  imports = [ ./fcitx5.nix ];
  # rime config
  home.file = {
    ".local/share/fcitx5/rime" = {
      source = ./rime-data-ama/share/rime-data;
      recursive = true;
    };
  };
}
