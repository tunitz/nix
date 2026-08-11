{ config, pkgs, inputs, host, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./pkgs.nix
    ./plasma.nix
    ./git.nix
    ./vscode.nix
    ./firefox.nix
  ];

  # --- Identity ---
  home.username = host;
  home.homeDirectory = "/home/${host}";

  programs.home-manager.enable = true;

  # Do not change this value. It tracks the version of HM you started with.
  home.stateVersion = "26.05";
}