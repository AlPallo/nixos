{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles.url = "github:AlPallo/dotfiles";

    rust-flake.url = "./rust";
  };

  outputs = { nixpkgs, home-manager, rust-flake, dotfiles, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        alex = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ({ pkgs, ... }: {
	      _module.args.dotfilesDir = dotfiles;
              home.packages = [ rust-flake.packages.${system}.default ];
            })
          ];
        };
      };
    };
}
