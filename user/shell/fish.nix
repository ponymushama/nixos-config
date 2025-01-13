{ config, pkgs, inputs, ... }:

{
  # fish
  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -gx TERM xterm-256color
    '';
    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "fzf.fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
    shellAliases = {
      # eza 相关别名
      ls = "eza";                                                 # 基础替换
      ll = "eza -l --icons --git";                                # 长列表
      la = "eza -la --icons --git";                               # 包含隐藏文件
      lt = "eza --tree --icons -a -I '.git|node_modules|.next'";  # 树状显示
      l = "eza -lah --icons --git";                               # 详细信息
      lg = "eza -la --icons --git-ignore";                        # 显示 git 状态
      # 目录导航
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      # 其他实用别名
      c = "clear";                    # 清屏
      h = "history";                  # 历史记录
      z = "cd";                       # zoxide
      sm = "sudoedit";                # edit
      ports = "netstat -tulanp";      # 查看端口占用
      path = "echo $PATH | tr ':' '\n'"; # 显示 PATH
    };
  };

  # zoxide
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # eza
  programs.eza.enableFishIntegration = true;
}
