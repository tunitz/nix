{ config, pkgs, ... }:

{
	# Enable CUPS to print documents.
	services.printing.enable = true;

	# --- Bootloader ---
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# --- Networking Daemon ---
	networking.networkmanager.enable = true;

	# --- Audio Core (PipeWire) ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

	# --- Global Nix Settings ---
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Automatically optimize the Nix store to save disk space
  nix.settings.auto-optimise-store = true;

  # Automatic Garbage Collection (deletes system generations older than 7 days)
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}