{ ... }:

{
  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select"; 
      colorScheme = "BreezeDark";
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "Reversal-black";
      soundTheme = "freedesktop";
    };

    configFile = {
      "kdeglobals"."KDE"."contrast" = "4";
      "kdeglobals"."KDE"."frameContrast" = "0.2";
      "ksplashrc"."KSplash"."Theme" = "org.kde.breeze.desktop";
      "ksplashrc"."KSplash"."Engine" = "KSplashQML";

      "kactivitymanagerd-statsrc"."Favorites-org.kde.plasma.kickoff.favorites.instance-50-global"."ordering" = 
        "applications:org.kde.discover.desktop,applications:org.kde.dolphin.desktop,applications:systemsettings.desktop,applications:org.kde.konsole.desktop,applications:steam.desktop,applications:code.desktop";
      
      "kactivitymanagerd-statsrc"."Favorites-org.kde.plasma.kickoff.favorites.instance-50-ae86ed81-03a0-4f62-861c-bb4b91baf62e"."ordering" = 
        "applications:org.kde.discover.desktop,applications:org.kde.dolphin.desktop,applications:systemsettings.desktop,applications:org.kde.konsole.desktop,applications:steam.desktop,applications:code.desktop";
    };

    shortcuts = {
      "kwin"."Window Close" = "Meta+Q";
      "services/org.kde.krunner.desktop"."_launch" = "Alt+Space";
    };

    panels = [
      {
        location = "top";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.marginsseparator"
          {
            systemTray = {
              items = {
                hidden = [
                  "org.kde.plasma.clipboard"
                ];
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
      {
        location = "bottom";
        alignment = "center";
        lengthMode = "fit";      
        hiding = "dodgewindows"; 
        opacity = "adaptive";    
        floating = true;         
        height = 64;             
        widgets = [
          {
            iconTasks = {
              launchers = [
                "preferred://filemanager"
                "preferred://browser"
              ];
            };
          }
        ];
      }
    ];
  };
}