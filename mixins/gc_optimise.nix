{ ... }: {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 180d";
    };
    optimise.automatic = true;
  };
}

