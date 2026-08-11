# ❄️ Tun's NixOS Configuration

A quick reference guide for managing, updating, and maintaining this NixOS flake configuration.

---

## 🚀 System Deployment

### Apply Changes Immediately (Switch)
Builds the new configuration and applies it to your current session right away. Use this for daily updates.
```bash
sudo nixos-rebuild switch --flake .#tunitz

```

### Apply on Next Restart (Boot)

Builds the new configuration but waits until you reboot to apply it. Use this for major kernel or display driver updates.

```bash
sudo nixos-rebuild boot --flake .#tunitz

```

### Rollback System

Instantly reverts your system back to the previous working generation if an update breaks something.

```bash
sudo nixos-rebuild switch --rollback

```

---

## 🔄 Updates & Upgrades

### Update All Inputs

Fetches the latest versions of all your flake inputs (`nixpkgs`, Home Manager, Plasma Manager).

```bash
sudo nix flake update

```

### Update a Specific Input

Updates only one specific source without touching the rest of your system.

```bash
sudo nix flake lock --update-input plasma-manager

```

---

## 🧹 Storage & Maintenance

### Clean Up Old Builds (Safe)

Deletes old system generations that are older than 7 days to free up disk space.

```bash
sudo nix-collect-garbage --delete-older-than 7d

```

### Clean Up All Old Builds (Aggressive)

Deletes *all* previous system generations, keeping only the currently active one.

```bash
sudo nix-collect-garbage -d

```

### Optimize Nix Store

Deduplicates identical files across the Nix store to reclaim storage space without deleting generations.

```bash
nix store optimise

```

---

## 🛠️ Troubleshooting

### Fix Git Permissions Error

Run this if `git add` throws an "insufficient permission" error because a rebuild caused files to be owned by `root`.

```bash
sudo chown -R $USER .git

```