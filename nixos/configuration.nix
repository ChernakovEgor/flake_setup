# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./postgre.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  environment.systemPackages = with pkgs; [
    htop
    go
    git
    neofetch
  ];
  programs.zsh.enable = true;

  networking.hostName = "gw0"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      5432
    ];
    allowedUDPPortRanges = [
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.egor = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "sudo"
    ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTtKQksaieD3oUPPN7HxL89LZdSbDi84C3FEIVRW8oK+2uAgtL4VTrg241XQMBmcxPa3qBnK4OSri5On7Yxv4LXEZMWDukTOzHBp7T9gnUkbcjJHrKQk1mhJlOGpEUDcKJ6MuG1QVf+MmTY7SvTk3YuzPgxY3s0P3FO67UTq/M+W8L9l1p0GfZUd+HY684B0tKGvVhtpmC2hkz7wwpJXicH68SSF6YREw+d6SK/jmo4PUkzThj3/KhSxgXI0N+YgNC8GAbKqR/0k6cvmxI08zZhk+jehvShrMPBCwboPVebNO9tmxNwdqeOkyK1LK+PLmaWmtvViGCCRIrzACOgxQLvBU7KeNjblB295EWU5v32WPoDDN/QPBNIprMmJFhC9qExcFhV+tBbCKCGD71VIdmMar5h2ejte9D93zfZqPPu11BpPtCANZpiiQb+OLBKTqi75hIYcGWwVsjP4fJy6sRpN0D1Q15wuwdfFGIjlxfUfru3989FwpIR3dB0GgUeEM= egor@MacBook-Pro-Egor.local"
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "egor" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/vim";
          options = [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  # vim
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # sshd
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "24.11"; # Did you read the comment?

}
