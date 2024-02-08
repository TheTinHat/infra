{ pkgs, ... }: {
  imports = [
    ./david.nix
  ];

  home.packages = with pkgs; [
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

  programs.bash.bashrcExtra = ''
      case $- in
      *i*) ;;
        *) return;;
      esac

      # set variable identifying the chroot you work in (used in the prompt below)
      if [ -z "$${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
          debian_chroot=$(cat /etc/debian_chroot)
      fi

      # set a fancy prompt (non-color, unless we know we "want" color)
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac

      if [ "$color_prompt" = yes ]; then
          PS1="''${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
      else
          PS1="''${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
      fi
      unset color_prompt force_color_prompt

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*)
          PS1="\[\e]0;''${debian_chroot:+(''$debian_chroot)}\u@\h: \w\a\]$PS1"
          ;;
      *)
          ;;
      esac

      # enable color support of ls and also add handy aliases
      if [ -x /usr/bin/dircolors ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
          alias ls='ls --color=auto'
          #alias dir='dir --color=auto'
          #alias vdir='vdir --color=auto'

          alias grep='grep --color=auto'
          alias fgrep='fgrep --color=auto'
          alias egrep='egrep --color=auto'
      fi
    '';
}
