{ pkgs, home-manager, ... }:
{

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

  system.userActivationScripts = {
    setEtcNixosOwnership =
      {
        text = ''
          ${pkgs.sudo}/bin/sudo }${pkgs.coreutils}/bin/chown -R david /etc/nixos
        '';
        deps = [ ];
      };
  };

  security.sudo.extraRules = [
    {
      users = [ "david" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  home-manager.users.david = { ... }: {
    programs.bash = {
      enable = true;
      shellAliases = {
        work = "source env/bin/activate";
        mkenv = "python3 -m venv env";
        alfred = "ssh alfred@alfred.wolf-atlas.ts.net";
        rust = "ssh admin@rust.wolf-atlas.ts.net";
        myip = "curl ifconfig.me && echo -e ''";
      };
    };

    programs.git = {
      enable = true;
      userName = "David Swanlund";
      userEmail = "10473778+TheTinHat@users.noreply.github.com";
    };

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 43200;
      enableSshSupport = true;
    };

    home.stateVersion = "23.11";
  };

}
