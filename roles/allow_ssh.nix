{ pkgs, ... }: {
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.AllowUsers = [ "david" ];
  };
}
