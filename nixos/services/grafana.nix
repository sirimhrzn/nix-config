{ config, ... }:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_port = 2362;
        http_addr = "0.0.0.0";
      };
    };
  };
}
