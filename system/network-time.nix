{ pkgs, options, ... }:

{
  # network
  networking.networkmanager.enable = true;
  networking.hostName = "ponymushama";
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # TUN/TAP mihomo-party
  security.wrappers.mihomo-party = {
    source = "${pkgs.mihomo-party}/bin/mihomo-party";
    capabilities = "cap_net_admin,cap_net_bind_service=+ep";
    owner = "root";
    group = "wheel";
  };

  # localization
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
