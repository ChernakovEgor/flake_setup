{ lib, pkgs, ... }:
{
  home = {

    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "25.05";
  };

  # custom options for programs
  programs = {
    jq.enable = true;
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Chernakov Egor";
      userEmail = "chernakov.eg@gmail.com";
      extraConfig = {
        init = {defaultBranch = "main";};
      };
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      # shellAliases = {
      #   ll = "ls -l";
      #   cd = "z";
      # };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          # "zsh-autosuggestions"
          "powerlevel10k"
        ];

        theme = "robbyrussell";
      };
    };
  };
}
