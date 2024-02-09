# infra

## Installation 
If needed, generate a new install ISO: 
```
nix build .#nixosConfigurations.installIso.config.system.build.isoImage
```

It will be saved in the ./results/iso/ directory. 

Boot the install image and run `infra` to automatically clone this repo. Then `cd infra` and run the install script: `sudo bash install.sh <host>`


## Updating Config
```
bash update.sh <host>
```


## Home Manager Standalone
Use to configure home directory of non-NixOS system (e.g. Ubuntu):
```
nix run nixpkgs#home-manager -- switch --flake ./#<user>
```
