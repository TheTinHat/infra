#!/bin/bash

host=$1
ip=$2

if [ -z "$host" ]; then
	echo "Host not specified."
	exit 1
fi

if [ ! -d "hosts/${host}" ]; then
	echo "Cannot find directory for host directory"
	exit 1
fi

if [ -z "$ip" ]; then
	echo "IP adddress not specified."
	exit 1
fi

ssh nixos@${ip} "git clone https://github.com/thetinhat/infra.git &&
  cd infra &&
  sudo nix run github:nix-community/disko -- --mode disko hosts/${host}/disko-config.nix &&
  nixos-generate-config --no-filesystems --root /mnt --dir hosts/${host}/ && 
  git add . &&
  sudo nixos-install --flake ./#${host} &&
  sudo mkdir -p /mnt/etc/nixos/ &&
  sudo git clone https://github.com/TheTinHat/infra.git /mnt/etc/nixos/infra &&
  sudo cp hosts/${host}/hardware-configuration.nix /mnt/etc/nixos/infra/hosts/${host}/
  "

rsync -avh nixos@${ip}:/mnt/etc/nixos/infra/hosts/${host}/hardware-configuration.nix ./hosts/${host}/
