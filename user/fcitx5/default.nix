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
    # fcitx5 theme
    fcitx5-rose-pine
    fcitx5-catppuccin
    fcitx5-material-color
  ];
  # fcitx5 config
  # imports = [ ./fcitx5.nix ];
  home.file = {
    ".config/fcitx5" = {
      source = ./fcitx5-config;
      recursive = true;
    };
  };
  # rime config
  home.file = {
    ".local/share/fcitx5/rime" = {
      source = ./rime-config;
      recursive = true;
    };
  };
}
