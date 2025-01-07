{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs;[
    # nvim
    neovim
    clang-tools
    gcc
    icu
    nodejs
  ];
  # nvim config
  home.file = {
    ".config/nvim" = {
      source = ./nvim-config;
      recursive = true;
    };
  };
}
