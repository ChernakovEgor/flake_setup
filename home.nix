{ lib, pkgs, ...}:
{
  home = {
    packages = with pkgs; [
      hello
      cowsay
      lolcat
      home-manager
    ];

    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "25.05";
  };
}
