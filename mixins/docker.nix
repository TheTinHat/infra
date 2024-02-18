{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    autoPrune.dates = "monthly";
    # rootless.enable = true;
    # rootless.setSocketVariable = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
  };
}

