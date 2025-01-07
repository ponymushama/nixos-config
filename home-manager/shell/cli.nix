{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs;[
    # clipboard
    xclip
    wl-clipboard

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
