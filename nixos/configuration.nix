# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./nixos/hardware-configuration.nix
      ./nixos/postgre.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  environment.systemPackages = with pkgs; [
      htop
      go
      git
      neofetch
  ];

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
      allowedTCPPorts = [ 22 5432 ];
      allowedUDPPortRanges = [
      ];
    };

  users.users.egor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "sudo"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [ 
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsazuCgo6+RxglcPJ8ympq+IQpZxpEUgxr7uGv+2mMcPPfMAPvrZFSMI2nzrJrA0adKKz3TzfkPuHbjbbPqqXHgm0ecUWT/rmDtqKMILDrrDR2PqKashAlnTGtPcgxam6DkXO2UyAIR9427QRD5VvYCxw5i4VaGWpk+mD1j1gQLXYsLJqpA3Ipv0myAmFq8BKP4zwiSpgu/4QEVBg8iER2L1HmgK7Xp1peGMrR9k1S0dcYgcM+QXQ8nVxP/NRG38u+ZvP1wjnUknpJFMl8wlQoEC70n2jK30E3/InQViCR4TdEA+ineFZVRIojp0cgk4NRKSPQXA6v7YmPxXg//KZHKWaxqgZ+cDF+5GAE54Pbub/SH5vkNnV8UjQs3g9+uNGOEzh9q553H76nygn5iXBttRweqnmdpXGsi09HHfbmTBU/55t2CTOV9mrfrLXfjV8PpsCh6/LwRPJCcZ1L/kmYLU5NEg/4+X9BzzUGWhi7I7xu2Sak2SgsZ4qOrUCytYU= egor@lab"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTtKQksaieD3oUPPN7HxL89LZdSbDi84C3FEIVRW8oK+2uAgtL4VTrg241XQMBmcxPa3qBnK4OSri5On7Yxv4LXEZMWDukTOzHBp7T9gnUkbcjJHrKQk1mhJlOGpEUDcKJ6MuG1QVf+MmTY7SvTk3YuzPgxY3s0P3FO67UTq/M+W8L9l1p0GfZUd+HY684B0tKGvVhtpmC2hkz7wwpJXicH68SSF6YREw+d6SK/jmo4PUkzThj3/KhSxgXI0N+YgNC8GAbKqR/0k6cvmxI08zZhk+jehvShrMPBCwboPVebNO9tmxNwdqeOkyK1LK+PLmaWmtvViGCCRIrzACOgxQLvBU7KeNjblB295EWU5v32WPoDDN/QPBNIprMmJFhC9qExcFhV+tBbCKCGD71VIdmMar5h2ejte9D93zfZqPPu11BpPtCANZpiiQb+OLBKTqi75hIYcGWwVsjP4fJy6sRpN0D1Q15wuwdfFGIjlxfUfru3989FwpIR3dB0GgUeEM= egor@MacBook-Pro-Egor.local"
    ];
  };

  security.sudo.extraRules= [
      {  users = [ "egor" ];
        commands = [
           { command = "/run/current-system/sw/bin/vim";
             options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
          }
        ];
      }
  ];


  # vim
  programs.vim = {
    enable = true;
    defaultEditor = true;
    package = (pkgs.vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [];
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

