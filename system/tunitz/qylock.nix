{ inputs, ... }:

{
  imports = [
    inputs.qylock.nixosModules.default
  ];
  programs.qylock = {
    enable = true;
    theme = "last-of-us"; # Select themes here --> https://github.com/Darkkal44/qylock/tree/main/themes
    sddm.enable = true;

    # Optional per-theme tweaks (replaces the interactive prompts):
    themeOptions = {
      last-of-us.backgroundMode = "time"; # time | random | static
      last-of-us.gameMode = "game";  # menu | game
      # clockwork.orbital = { themeMode = "dark"; enableWindup = true; };
    };
  };
}