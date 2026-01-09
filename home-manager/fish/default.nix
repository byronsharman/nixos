{ ... }:

{
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config.fish;
    shellAliases = {
      du = "du -h";
      grep = "grep --color";
      ip = "ip -c";
      ls = "ls --color --group-directories-first";
      tree = "tree --dirsfirst";
    };
  };
}
