{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # --- Enterprise Policies (Kills bloat & telemetry) ---
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

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # --- About:Config Performance, Vertical Tabs & 10ms Animations ---
      settings = {
        # 1. Enable Native Vertical Tabs & Revamp
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;

        # 2. Lightning-fast 10ms Sidebar & Expand-on-Hover Animations
        "sidebar.animation.enabled" = true;
        "sidebar.animation.duration-ms" = 10;
        "sidebar.animation.expand-on-hover.duration-ms" = 10;

        # 3. Wayland & Graphics (Crucial for KDE Plasma 6 smoothness)
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;

        # 4. Smooth Scrolling
        "general.smoothScroll" = true;
        "mousewheel.default.delta_multiplier_y" = 100;

        # 5. Clean New Tab Page (Removes sponsored stories & clutter)
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        
        # 6. Disable update nag screens
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
      };
    };
  };
}