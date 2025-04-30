{ config, pkgs, ... }:

{
  home.username = "egor";
  home.homeDirectory = "/home/egor";

  home.packages = with pkgs; [
    nmap
    jq
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Chernakov Egor";
    userEmail = "chernakov.eg@gmail.com";
  };


  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
