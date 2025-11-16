{config, ...}: {
  networking.computerName = "m4siri";
  networking.hostName = config.networking.computerName;

  networking.dns = [
    "8.8.8.8"
    "8.8.4.4"
    "2001:4860:4860::8888"
    "2001:4860:4860::8844"
  ];

  networking.knownNetworkServices = [
    "Wi-Fi"
  ];

  networking.domain = "homelab.io";
  networking.search = [
    "homelab.io"
  ];
}
