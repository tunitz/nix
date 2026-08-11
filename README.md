# Useful commands so I don't forget

Commands I need on a daily basis. I only have 256mb of brain memory

---

## System Deployment

### Apply Changes Immediately (Switch)
Rebuilds and apply right away. (#tunitz) is the host name
```bash
sudo nixos-rebuild switch --flake .#tunitz

```

### Apply on Next Restart (Boot)

Rebuilds and apply after reboot. (#tunitz) is the host name

```bash
sudo nixos-rebuild boot --flake .#tunitz

```

### Rollback System

Rollback to previous working build

```bash
sudo nixos-rebuild switch --rollback

```

---

## Updates & Upgrades

### Update All Inputs

Update packages. Needs to rebuild after

```bash
sudo nix flake update

```

### Update a Specific Input

Updates only one specific source without touching the rest of your system.

```bash
sudo nix flake lock --update-input plasma-manager

```

---

## Storage & Maintenance

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

## Troubleshooting

### Fix Git Permissions Error

Run this if `git add` throws an "insufficient permission" error because a rebuild caused files to be owned by `root`.

```bash
sudo chown -R $USER .git

```