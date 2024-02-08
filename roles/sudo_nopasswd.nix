{ ... }: {
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
