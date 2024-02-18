{ lib, pkgs, ... }:
with lib;
with pkgs;
{
  options.packages = {
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
      ];
      description = "Development Tools";
    };

    core = mkOption {
      type = types.listOf (types.package);
      default = with pkgs; [
        curl
        git
        htop
        lazygit
        rsync
        tailscale
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
        neovim
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
        gnome.gnome-tweaks
        inkscape
        libreoffice
        obsidian
        OVMFFull
        prusa-slicer
        qgis
        steam
        syncthing
        tor-browser-bundle-bin
        virt-manager
        vlc
      ];
      description = "Desktop GUI programs";
    };
  };
}
