{ host, ... }:

{
  networking.hostName = host;

  users.users.${host} = {
    isNormalUser = true;
    description = "${host}";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}