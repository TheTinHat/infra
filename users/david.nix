{ pkgs, home-manager, ... }: {

  home-manager.users.david = import ../home-manager/david.nix;

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
}
