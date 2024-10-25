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

nix run .#apps.nixinate.${host}
