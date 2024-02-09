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

# Format disk
sudo nix run github:nix-community/disko -- --mode disko hosts/${host}/disko-config.nix
# Generate config
nixos-generate-config --no-filesystems --root /mnt --dir hosts/${host}/
git add .

# Install NixOS
sudo nixos-install --flake ./#${host}

# Add config to new system
sudo mkdir -p /mnt/etc/nixos/
sudo git clone https://github.com/TheTinHat/infra.git /mnt/etc/nixos/infra
sudo cp hosts/${host}/hardware-configuration.nix /mnt/etc/nixos/infra/hosts/${host}/
