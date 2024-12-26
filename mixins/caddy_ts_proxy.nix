{
  services.tailscale = {
    enable = true;
    permitCertUid = "caddy";
    interfaceName = "userspace-networking";
  };
  services.caddy = {
    enable = true;
  };
  systemd.services.caddy = {
    after = [ "tailscaled.service" ];
    requires = [ "tailscaled.service" ];
  };
}
