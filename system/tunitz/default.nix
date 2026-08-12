{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./pkgs.nix
    ./steam.nix
    ./docker.nix
    ./qylock.nix
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
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      kdePackages.qt5compat # required for qylock themes
    ];
  };
  
  # Desktops
  services.desktopManager = {
    # cosmic.enable = true;
    plasma6.enable = true;
  };
  
  # Hardware acceleration
  hardware.graphics.enable = true;

  # Maintain SSD performance
  services.fstrim.enable = true;

  # Keep CPU clocks high for lower latency
  powerManagement.cpuFreqGovernor = "performance";

  system.stateVersion = "23.11";
}