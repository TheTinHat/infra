# infra


```

cd hosts/ 
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko <host>/disko-config.nix
nixos-generate-config --no-filesystems --root /mnt --dir <host>
git add .
sudo nixos-install --flake .#<host>

nixos-rebuild --flake /path/do/flake/#yourHostNameGoesHere switch
```
