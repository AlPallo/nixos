{ config, lib, pkgs, ... }:
let
  dotfiles =
    builtins.fetchGit { name = "https://github.com/AlPallo/dotfiles.git"; };
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in {
  home = {
    packages = with pkgs; [
      pkgs.wget
      pkgs.ripgrep
      pkgs.fd
      pkgs.lua
      pkgs.python313
      pkgs.home-manager
      pkgs.gnumake
      pkgs.gcc
      pkgs.unzip
      pkgs.nodejs_24
      pkgs.tmux
    ];

    username = "alex";
    homeDirectory = "/home/alex";

    file = {
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
      ".config/tmux".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/tmux";
      ".config/fish/config.fish".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/fish/config.fish";
      ".config/fish/config.fish".force = true;
    };

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.
    stateVersion = "23.11";
  };

  programs = {
    fish.enable = false;
    git = { enable = true; };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaPackages = ps:
        with pkgs.vimPlugins; [
          packer-nvim
          telescope-nvim
          nvim-treesitter
          oil-nvim
          noice-nvim
          nvim-web-devicons
          mason-nvim
          mason-lspconfig-nvim
        ];
    };
  };
}
