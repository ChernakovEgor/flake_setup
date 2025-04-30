{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      home-manager
    ];

    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "25.05";
  };

  programs = {
    git = {
      enable = true;
      userName = "Chernakov Egor";
      userEmail = "chernakov.eg@gmail.com";
    };
  };
}
