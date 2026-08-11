{ config, pkgs, inputs, host, ... }:

{
  # 1. Import plasma-manager so you can control KDE themes from here
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  # --- Identity ---
  home.username = host;
  home.homeDirectory = "/home/${host}";

  programs.home-manager.enable = true;

  # --- Apps & Packages ---
  # These are installed ONLY for this user, keeping the system clean.
  home.packages = with pkgs; [
    bun
    discord
    reversal-icon-theme
    kdePackages.kate
  ];

  # Plasma Manager
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

  # Install firefox
  programs.firefox.enable = true;

  # Git configs
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "tunitz";
        email = "labillar@tunitz.com";
      };
      init.defaultBranch = "main";
    };
  };

  # VSCode
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      esbenp.prettier-vscode
      bbenoist.nix
      ms-azuretools.vscode-docker
    ] ++ [
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "bun-vscode";
        publisher = "oven";
        version = "0.0.32";
        sha256 = "sha256-VlruOHiF5/wVhVVW1rq6DEc90u3IwbxD/tpTXyphD+U=";
      })
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "hono";
        publisher = "hono";
        version = "0.0.3";
        sha256 = "sha256-Tu/Zx4rjrXn4GschwZhZvF7A/gDn3mk+RzpeSb3J1Zg=";
      })
    ];
  };

  # Do not change this value. It tracks the version of HM you started with.
  home.stateVersion = "26.05";
}