/**
  Base System Defaults Module
  
  Provides baseline system settings for booting, hardware acceleration, audio, desktop environments, and Nix package management.
  
  You are REQUIRED to create a new directory containing a `default.nix` file where you will define your custom configurations and overrides. 
  Additionally, you must generate a hardware configuration file (`hardware-configuration.nix`) for your specific host machine and import it into that new `default.nix` file.
  
  Note: The directory name you create must exactly match the flake output name used in your rebuild command. 
  For example, if your directory is named `mynewdirectory`, you would run:
  sudo nixos-rebuild [switch/build/boot...] --flake .#mynewdirectory
*/
{ lib, ... }:

{
  # Core System Services
  services = lib.mkDefault {
    printing.enable = true; # Enables CUPS for document printing

    # Audio Server (PipeWire)
    # Replaces PulseAudio with the modern PipeWire standard while maintaining compatibility
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Display Manager (Login Screen)
    # Uses SDDM configured with Wayland support
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Desktop Environment
    # Sets KDE Plasma 6 as the default graphical interface
    desktopManager = lib.mkDefault {
      plasma6.enable = true;
    };
  };

  # RealtimeKit (RTKit)
  # Grants real-time CPU priority to essential background services (crucial for smooth audio via PipeWire)
  security.rtkit.enable = lib.mkDefault true; 

  # Bootloader Configuration
  # Uses systemd-boot for UEFI systems with a 3-second boot menu timeout
  boot.loader = lib.mkDefault {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Hardware Acceleration
  # Enables standard graphics processing (OpenGL/Vulkan)
  hardware.graphics.enable = lib.mkDefault true;

  # Networking
  # Enables NetworkManager to handle Wi-Fi and Ethernet connections
  networking.networkmanager.enable = lib.mkDefault true;

  # Proprietary Software
  # Permits the installation of closed-source packages (e.g., Steam, Discord, GPU drivers)
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  # Global Nix Package Manager Settings
  # Enables modern flake features, auto-optimizes the Nix store to save space, and uses all CPU cores for builds
  nix.settings = lib.mkDefault {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    warn-dirty = false;
    cores = 0;
    max-jobs = "auto";
  };

  # Automatic Garbage Collection
  # Runs a weekly task to delete system generations older than 3 days, freeing up disk space
  nix.gc = lib.mkDefault {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  # System State Version
  # Defines the initial NixOS release version for stateful data compatibility (Do not change this after installation)
  system.stateVersion = lib.mkDefault "26.05";
}