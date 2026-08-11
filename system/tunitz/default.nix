{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./steam.nix
  ];

  # Performance boost when gaming
  programs.gamemode.enable = true;

  # Gaming kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # --- Graphical Desktop (KDE Plasma for this PC) ---
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  # --- Virtualization ---
	virtualisation.docker.enable = true;
  
  # Hardware acceleration
  hardware.graphics.enable = true;

  # State version is tied to the host's installation date
  system.stateVersion = "26.05";
}