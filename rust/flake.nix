{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, fenix, nixpkgs }: {
    packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
  };
}
