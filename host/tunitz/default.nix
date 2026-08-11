{ host, ... }:

{
  networking.hostName = host;

  users.users.${host} = {
    isNormalUser = true;
    description = "${host}'s home";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}