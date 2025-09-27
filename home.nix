{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "alex";
    homeDirectory = "/home/alex";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.
    stateVersion = "23.11";
  };
}
