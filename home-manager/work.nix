{ pkgs, ... }: {
  imports = [
    ./david.nix
  ];

  programs.bash.shellAliases = {
    dj="python manage.py";
    djt="python manage.py test --parallel auto --failfast --exclude-tag=slow --exclude-tag=liveserver --exclude-tag=aws";
    djs="python manage.py heatserver";

    sai="sudo apt install";
    sup="sudo apt update && sudo apt upgrade -y";
    sas="sudo apt-cache search";

    heat="cd ~/heat && source ./env/bin/activate && nvim";
    solar="cd ~/solar && source ./env/bin/activate && nvim";

    heat1="cd ~/heat/deploy/scripts/ && aws-vault exec heat-staging-iac  ./ecs_exec.sh heat-staging-1-cluster";
    heat2="cd ~/heat/deploy/scripts/ && aws-vault exec heat-staging-iac  ./ecs_exec.sh heat-staging-2-cluster";
  };
}
