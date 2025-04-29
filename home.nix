{ lib, pkgs, ...}:
{
  home = {
    packages = with pkgs; [
      hello
      cowsay
      lolcat
    ];

    username = "egor";
    homeDirectory = "/home/egor";

    stateVersion = "24.11";
  };
}
