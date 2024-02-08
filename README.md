# infra

```
nix-shell -p git
git clone https://github.com/TheTinHat/infra.git
cd infra
bash install.sh <hostname>
```

Home Manager standalone:

```
nix run nixpkgs#home-manager -- switch --flake #<user>
```
