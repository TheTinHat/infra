{ ... }: {
  virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "monthly";
      rootless.enable = true;
      rootless.setSocketVariable = true;
  };
}
