{ lib, pkgs, ... }:
{
  home = {

    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "25.05";
  };

  # custom options for programs
  programs.vim = {
    enable = true;
    defaultEditor = true;
    package = (pkgs.vim_configurable.override { }).customize {
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [
          vim-nix
          vim-lastplace
        ];
        opt = [ ];
      };
      vimrcConfig.customRC = ''
        " your custom vimrc
        set expandtab
        set tabstop=4
        set shiftwidth=4
        set autoindent
        set smartindent
        set ignorecase
        set smartcase
        set relativenumber
        " Turn on syntax highlighting by default
        syntax on
        " ...
      '';
    };
  };
  programs = {
    jq.enable = true;
    home-manager.enable = true;
    neovim.enable = true;


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
      enableAutosuggestions = true;
      enableCompletion = true;
      # shellAliases = {
      #   ll = "ls -l";
      #   cd = "z";
      # };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          # "zsh-autosuggestions"

        ];

        theme = "robbyrussell";
        # theme = "powerlevel10k/powerlevel10k";
      };
    };
  };
}
