/**
  Base User Configuration (Home Manager)
  
  WARNING: Do not modify this file directly unless you know exactly what you are doing. This file handles the core plumbing required to integrate Home Manager with NixOS.
  
  OPTIONAL: You can optionally create a new directory that exactly matches your host/user name (the `host` variable) containing a `default.nix` file.
  This allows you to override these defaults and define machine-specific personal configurations, dotfiles, and themes.

  Note: If you choose to create a host-specific directory, its name must exactly match the flake output name used in your rebuild command. 
  For example, if your directory is named `my-pc`, you would run:
  sudo nixos-rebuild [switch/build/boot...] --flake .#my-pc
*/
{ lib, host, pkgs, ... }:

{
  # Identity
  home.username = host;
  home.homeDirectory = "/home/${host}";

  programs.home-manager.enable = true;

  # Firefox Configuration
  programs.firefox = lib.mkDefault {
    enable = true;

    # Enterprise Policies (Kills bloat & telemetry)
    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };

  # VSCode because it's the best!
  programs.vscode = lib.mkDefault {
    enable = true;
    package = pkgs.vscode;
  };

  # State version (Do not change this after initial installation)
  home.stateVersion = "26.05";
}