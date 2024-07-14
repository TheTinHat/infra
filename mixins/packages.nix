{ lib, pkgs, ... }:
with lib;
with pkgs;
{
  options.packages = {
    core = mkOption {
      type = types.listOf (types.package);
      default = with pkgs; [
        curl
        git
        htop
        lazygit
        rsync
        tailscale
        unzip
        vim
      ];
      description = "Core Utilities";
    };

    extra = mkOption {
      type = types.listOf (types.package);
      default = with pkgs; [
        age
        fd
        gcc
        jq
        nerdfonts
        ripgrep
        sops
        tree
        wget
      ];
      description = "Extra Utilities";
    };

    gui = mkOption {
      type = types.listOf (types.package);
      default = with pkgs; [
        bitwarden
        chromium
        darktable
        element-desktop
        firefox
        flatpak
        gimp
        inkscape
        libreoffice
        obsidian
        OVMFFull
        pandoc
        prusa-slicer
        qgis
        signal-desktop
        steam
        syncthing
        thunderbird
        tor-browser-bundle-bin
        virt-manager
        vlc
        zotero
      ];
      description = "Desktop GUI programs";
    };

    placeholder = mkOption {
      type = types.listOf (types.package);
      default = with pkgs; [
        # package
      ];
      description = "Description";
    };

    dev = mkOption {
      type = types.listOf (types.package);
      default = with pkgs; [
        # package
        nodejs
        rustc
        rustup
        cargo
      ];
      description = "Development Tools";
    };
  };
}
