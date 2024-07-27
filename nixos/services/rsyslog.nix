{ config, ... }:
{
  services.rsyslogd = {
    enable = true;
    extraConfig = ''
    # module(load="imtcp")
    module(load="imudp")

    # Run TCP and UDP servers
    # input(type="imtcp" port="514")
    input(type="imudp" port="514")

    $template DynamicFile,"/var/log/%programname%-%$YEAR%%$MONTH%%$DAY%.log"

    *.* ?DynamicFile
    & stop
    '';
  };
}
