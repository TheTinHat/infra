{ pkgs, ... }: {

  imports = [ 
    ../home-manager/david.nix
  ];

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
  ;
}
