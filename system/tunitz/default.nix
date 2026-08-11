{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./steam.nix
    ./docker.nix
  ];

  # Bloatwares
  environment.defaultPackages = with pkgs; [
    curl
    nano
  ];

  # Performance boost when gaming
  programs.gamemode.enable = true;

  # Gaming kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Display manager
  services.displayManager.sddm.enable = true;
  
  # KDE Plasma
  # services.desktopManager.plasma6.enable = true;

  # Cosmic
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.cosmic.enable = true;
  
  # Hardware acceleration
  hardware.graphics.enable = true;

  # Maintain SSD performance
  services.fstrim.enable = true;

  # Keep CPU clocks high for lower latency
  powerManagement.cpuFreqGovernor = "performance";

  system.stateVersion = "23.11";
}