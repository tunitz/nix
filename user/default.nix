/**
  Home Manager Integration Module
  
  WARNING: Do not modify this file directly unless you know exactly what you are doing. This file handles the core plumbing required to integrate Home Manager with NixOS.
  
  REQUIRED to create a new directory that exactly matches your host/user name (the `host` variable). Inside that directory, you must create a `default.nix` file.
  This is where you will define all of your personal, user-level configurations (dotfiles, user packages, themes, etc.).

  Note: The directory name you create must exactly match the flake output name used in your rebuild command. 
  For example, if your directory is named `mynewdirectory`, you would run:
  sudo nixos-rebuild [switch/build/boot...] --flake .#mynewdirectory
*/
{ inputs, host, ... }:

{
  # Import the Home Manager module from the flake inputs
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Core Home Manager Configuration
  home-manager = {
    # Use the system-level Nixpkgs instead of managing a separate instance for the user
    useGlobalPkgs = true;
    
    # Install user packages directly to /etc/profiles/per-user instead of ~/.nix-profile
    useUserPackages = true;
    
    # Automatically backup existing dotfiles (e.g., .bashrc -> .bashrc.backup) 
    # to prevent build failures when Home Manager tries to manage them
    backupFileExtension = "backup";
    
    # Pass flake inputs and the host variable down to your user-level configurations
    extraSpecialArgs = { inherit inputs host; };
    
    # Dynamically map the primary user to their dedicated configuration folder
    # This automatically imports the `./<host>/default.nix` file you are required to create
    users.${host} = import ./${host}/default.nix; 
  };
}