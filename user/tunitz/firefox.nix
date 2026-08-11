{ ... }:

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
  };
}