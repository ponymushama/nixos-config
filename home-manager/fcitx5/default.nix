{ config, pkgs, inputs, ... }:
# let
#   customPkgs = pkgs.extend (self: super: {
#     fcitx5-rime = super.fcitx5-rime.override {
#       rimeDataPkgs = [ 
#         (super.callPackage ./rime-data-ama {})
#       ];
#     };
#   });
# in
{
  # fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons =
    # let
    #   config.packageOverrides = pkgs: {
    #     fcitx5-rime = pkgs.fcitx5-rime.override {
    #         rimeDataPkgs = [./rime-data-ama];
    #     };
    #   };
    # in
    with pkgs; [
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
