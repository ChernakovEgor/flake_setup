{ lib, pkgs, ... }: {
  home = {
    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "25.05";
  };

  programs = {
    go.enable = true;
    jq.enable = true;
    home-manager.enable = true;
    ripgrep.enable = true;
    neovim.enable = true;

    git = {
      enable = true;
      userName = "Chernakov Egor";
      userEmail = "chernakov.eg@gmail.com";
      extraConfig = { init = { defaultBranch = "main"; }; };
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
      };
    };

    tmux = {
      enable = true;
      plugins = with pkgs;
        [
          tmuxPlugins.vim-tmux-navigator # for navigating panes and vim/nvim with Ctrl-hjkl
          # tmuxPlugins.themepack # to configure tmux theme
          # tmuxPlugins.resurrect # persist tmux sessions after computer restart
          # tmuxPlugins.continuum # automatically saves sessions for you every 15 minutes
          # tmuxPlugins.tpm
        ];
      extraConfig = ''
        set -g default-terminal "screen-256color"

        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix

        unbind %
        bind | split-window -h 

        unbind '"'
        bind - split-window -v

        unbind r
        bind r source-file ~/.tmux.conf

        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r l resize-pane -R 5
        bind -r h resize-pane -L 5

        bind -r m resize-pane -Z

        set -g mouse on
        set-option -g status on
        set-option -g status-interval 2
        set-option -g status-position top
        set-option -g status-justify "centre"
        set-option -g status-left-length 60
        set-option -g status-right-length 90
        set -g status-bg cyan


        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
        bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

        unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode when dragging with mouse


        # tpm plugin

        # list of tmux plugins
        # set -g @plugin 'erikw/tmux-powerline'

        # set -g @themepack 'powerline/default/cyan' # use this theme for tmux
        set -g @themepack 'basic'

        set -g @resurrect-capture-pane-contents 'on' # allow tmux-ressurect to capture pane contents
        set -g @continuum-restore 'off' # enable tmux-continuum functionality

        # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
        run '~/.tmux/plugins/tpm/tpm'
      '';
    };
  };
}
