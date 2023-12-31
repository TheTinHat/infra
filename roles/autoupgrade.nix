{ ... }: {
  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    randomizedDelaySec = "30min";
  };
}
