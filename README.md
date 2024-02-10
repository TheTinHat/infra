# infra

## Installation 
If needed, generate a new install ISO: 
```
nix build .#nixosConfigurations.installIso.config.system.build.isoImage
```

It will be saved in the ./results/iso/ directory. 

Boot the install image run `ip a` to get the IP address. Then run the install script: 
```
bash install.sh <host> <ip>
```

## Updating Config
```
bash update.sh <host>
```

## Home Manager Standalone
Use to configure home directory of non-NixOS system (e.g. Ubuntu):
```
nix run nixpkgs#home-manager -- switch --flake ./#<user>
```
