{ ... }: {
  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    randomizedDelaySec = "30min";
    
    ## REQUIRES TESTING FOR FLAKE COMPATIBILITY
    ## https://nixos.wiki/wiki/Automatic_system_upgrades
    #flake = inputs.self.outPath;
    #flags = [
    #  "--update-input"
    #  "nixpkgs"
    #  "-L" # print build logs
    #];
  };
}
