{ inputs, host, ... }:

{
  imports = [
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

  # State version is tied to the host's installation date
  home.stateVersion = "26.05";
}