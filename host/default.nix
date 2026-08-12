/**
  Base System Defaults Module
  
  Provides baseline system settings for timezone, localization, hostname, and the primary user account.
  
  To override any of these settings, you can optionally create a new directory containing a `default.nix` file where you can define your custom configurations. 
  
  Note: If you choose to do this, the directory name must exactly match the flake output name used in your rebuild command. 
  For example, if your directory is named `mydirectory`, you would run:
  sudo nixos-rebuild [switch/build/boot...] --flake .#mydirectory
*/
{ lib, host, ... }:

{
  # System Timezone
  time.timeZone = lib.mkDefault "Asia/Manila";

  # Internationalization (i18n) & Regional Formatting
  # Uses English (Philippines) for UI text, and Filipino standards for currency, dates, and measurements
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

  # Set system hostname dynamically from the 'host' argument
  networking.hostName = lib.mkDefault host;

  # Primary User Account setup (defaults account name to match the 'host' argument)
  users.users.${host} = lib.mkDefault {
    isNormalUser = true; # Allocates standard UID (>= 1000) and creates /home/${host}
    description = "${host}";
    extraGroups = [ 
      "networkmanager"   # Allows user to connect/manage Wi-Fi & networks without sudo
      "wheel"            # Grants sudo / admin privileges
    ];
  };
}