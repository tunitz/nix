{ ... }:

let
  user = "tunitz";
in
{
  networking.hostName = user;

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}'s home";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}