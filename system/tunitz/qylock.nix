{ inputs, ... }:

{
  imports = [
    inputs.qylock.nixosModules.default
  ];
  programs.qylock = {
    enable = true;
    theme = "pixel-night-city"; # Select themes here --> https://github.com/Darkkal44/qylock/tree/main/themes
    sddm.enable = true;

    # themeOptions = {
    #   terraria.backgroundMode = "time";
    #   Genshin.backgroundMode = "time";
    #   clockwork.orbital = { themeMode = "dark"; enableWindup = true; };
    #   osu.gameMode = "menu";
    # };
  };
}