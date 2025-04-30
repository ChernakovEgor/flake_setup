{ lib, pkgs, ...}:
{
  home = {

    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "25.05";
  };

  # generic packages
  packages = with pkgs; [
    # jq
    hello
    lolcat
  ];

  # custom options for programs
  programs = {
    git = {
      enable = true;
      userName = "Chernakov Egor";
      userEmail = "chernakov.eg@gmail.com";
    };

  };
 
  programs.home-manager.enable = true;
}
