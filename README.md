# ❄️ Tunitz NixOS Configuration

This is my NixOS configs. 
I want this to be strict but modular where anyone can easily create their own configs for their own machine.

## ✨ Features

* **Dynamic Host Generation**: The master flake automatically detects new machines based on folder names in the `host/`, `system/`, and `user/` directory.
* **Strict Modularity**: Core plumbing is separated from hardware configs and user dotfiles.

---

## 📂 Directory Architecture

The repository enforces a strict 3-pillar structure: `host`, `system`, and `user`. 

```text
.
├── flake.nix                           # The master orchestrator
├── host/                               # 1. Base network & user identities
│   ├── default.nix                     # Global defaults (Timezone, Locales, User Groups)
│   └── <hostname>/                     # (Optional) Host-specific overrides
│
├── system/                             # 2. System services & hardware
│   ├── default.nix                     # Global services (Bootloader, PipeWire, SDDM, Garbage Collection)
│   └── <hostname>/
│       ├── default.nix                 # (REQUIRED) Machine-specific system overrides
│       └── hardware-configuration.nix  # (REQUIRED) Auto-generated hardware profile
│
└── user/                               # 3. Home Manager & Dotfiles
    ├── default.nix                     # Core Home Manager plumbing
    └── <hostname>/
        └── default.nix                 # (REQUIRED) User packages, dotfiles, and Desktop configs