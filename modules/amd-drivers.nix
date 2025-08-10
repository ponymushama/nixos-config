# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.amdgpu;
in
{
  options.drivers.amdgpu = {
    enable = mkEnableOption "Enable AMD Drivers";
  };

  config = mkIf cfg.enable {
    # 注释掉有问题的 tmpfiles 规则
    # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
 
    # OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        # 添加 ROCm 支持但不使用有问题的 clr
        rocmPackages.rocm-runtime
        rocmPackages.rocm-device-libs
      ];
    };
  };
}
