{ lib, pkgs, ...}:
{
  home = {

    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "25.05";
  };


  # custom options for programs
  programs = {
    git = {
      enable = true;
      userName = "Chernakov Egor";
      userEmail = "chernakov.eg@gmail.com";
    };

    jq.enable = true;
    home-manager.enable = true;
  };
}
