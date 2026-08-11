{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    discord
    reversal-icon-theme
    kdePackages.kate
    protonup-qt
    qbittorrent
  ];
}