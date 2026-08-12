/**
  Default configuration for user related configs.
  No need to modify this file, instead, create a directory with a default.nix file where you can customize as you want per host.
*/
{ lib, host, ... }:

{
  # Region
  time.timeZone = lib.mkDefault "Asia/Manila";

  # Select internationalisation properties.
  i18n = lib.mkDefault {
    defaultLocale = "en_PH.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fil_PH";
      LC_IDENTIFICATION = "fil_PH";
      LC_MEASUREMENT = "fil_PH";
      LC_MONETARY = "fil_PH";
      LC_NAME = "fil_PH";
      LC_NUMERIC = "fil_PH";
      LC_PAPER = "fil_PH";
      LC_TELEPHONE = "fil_PH";
      LC_TIME = "fil_PH";
    };
  };

  # Default hostname
  networking.hostName = lib.mkDefault host;

  # Default user
  users.users.${host} = lib.mkDefault {
    isNormalUser = true;
    description = "${host}";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}