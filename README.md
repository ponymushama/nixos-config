# ponymushama nixos-config

**install**

```bash
nix-shell -p git --command "nix run --experimental-features 'nix-command flakes' github:ponymushama/nixos-config"
```

**update hardware**

```bash
sudo nixos-generate-config --show-hardware-config > /home/ama/.dotfiles/system/hardware-configuration.nix
```
