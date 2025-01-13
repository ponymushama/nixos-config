{ pkgs, ... }:

{
  # system fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      sarasa-gothic
      lxgw-wenkai
      lxgw-wenkai-screen
      lxgw-neoxihei
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts
      fira-code
      noto-fonts-cjk-sans
      jetbrains-mono
      font-awesome
      terminus_font
      #(nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
      nerd-fonts.jetbrains-mono # unstable
      nerd-fonts.fira-code # unstable
    ];
  };

}
