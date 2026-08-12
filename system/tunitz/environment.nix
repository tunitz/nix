{ pkgs, ... }:

{
  environment = {
    # Bloatwares
    defaultPackages = with pkgs; [
      curl
      nano
    ];

    # Additional System level packgs
    systemPackages = with pkgs; [
      # Add packages here
    ];

    # Session Variables
    sessionVariables = {
      # WLR_NO_HARDWARE_CURSORS = "1"; 
      # NIXOS_OZONE_WL = "1";
    };
  };
}