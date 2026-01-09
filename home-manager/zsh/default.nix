{ ... }:

{
  programs.zsh = {
    enable = true;

    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    defaultKeymap = "viins";
    enableCompletion = true;
    enableVteIntegration = true;
    envExtra = ''
      if [ -e /home/byron/.nix-profile/etc/profile.d/nix.sh ]; then . /home/byron/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
    initContent = builtins.readFile ./init.sh;
    shellAliases = {
      du = "du -h";
      grep = "grep --color";
      ip = "ip -c";
      ls = "ls --color --group-directories-first";
      tree = "tree --dirsfirst";
    };
    syntaxHighlighting.enable = true;
  };
}
