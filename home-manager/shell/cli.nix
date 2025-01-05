{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs;[
    # lazyvim
    neovim
    clang-tools
    gcc
    icu
    nodejs

    # clipboard
    xclip
    wl-clipboard

    # rime enable lua
    librime
    librime-lua

    # lang
    rustc
    cargo
    python3Full

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    tmux
    lazygit
    fastfetch
    ripgrep
    eza
    fzf
    bat
    fd
    tldr
    zoxide
    which
  ];
}
