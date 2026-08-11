{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./steam.nix
    ./docker.nix
  ];

  # Performance boost when gaming
  programs.gamemode.enable = true;

  # Gaming kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # --- Graphical Desktop (KDE Plasma for this PC) ---
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  # Hardware acceleration
  hardware.graphics.enable = true;

  # Maintain SSD performance
  services.fstrim.enable = true;

  # Keep CPU clocks high for lower latency
  powerManagement.cpuFreqGovernor = "performance";

  system.stateVersion = "23.11";
}