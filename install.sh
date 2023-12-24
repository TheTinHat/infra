#!/bin/bash

host=$1

if [ -z "$host" ]; then
  echo "Host not specified."
  exit 1
fi

if [ ! -d "hosts/${host}" ]; then
  echo "Cannot find directory for host directory"
  exit 1
fi

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko hosts/${host}/disko-config.nix
nixos-generate-config --no-filesystems --root /mnt --dir hosts/${host}/
git add .

sudo nixos-install --flake ./hosts/#${host}

sudo mkdir /mnt/etc/nixos/
sudo mkdir /mnt/etc/nixos/${host}/
sudo cp -r hosts/flake.nix /mnt/etc/nixos/
sudo cp -r hosts/${host}/* /mnt/etc/nixos/${host}/

