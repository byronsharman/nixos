{ pkgs, ... }:

{
  imports = [ ./nvim ./fish ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "byron";
  home.homeDirectory = "/home/byron";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    numbat
    typst
  ] ++ import ./nvim/lsp_packages.nix pkgs;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/byron/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    x11.enable = true;
    size = 24;
  };

  home.preferXdgDirectories = true;
 
  xdg.configFile."niri/config.kdl".source = niri/config.kdl;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    discord.enable = true;

    fzf = {
      enable = true;
      # enabling it manually allows me to disable Alt-C
      # see https://github.com/junegunn/fzf/issues/1238
      enableZshIntegration = false;
    };

    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        merge.tool = "nvimdiff";
        user = {
          email = "byron.n.sharman@gmail.com";
          name = "byronsharman";
        };
      };
    };

    keepassxc = {
      enable = true;
      settings = {
        Browser.Enabled = true;
        SSHAgent.Enabled = true;
      };
    };

    ssh = {
      enable = true;
      # disable deprecated default config
      enableDefaultConfig = false;
      # most of these are copied from the previous default config
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "yes";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };

  services.cliphist = {
    enable = true;
    extraOptions = [ "-max-items" "10" ];
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
