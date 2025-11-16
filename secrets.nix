let
  siri = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMrczZPQlkb9TwtLa5YKs6Npu2vXtG4yJa0AWmwOLtfF siri@m4siri"
  ];
in {
  "modules/common/ssh/config.age".publicKeys = siri;
}
