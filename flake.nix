{
  description = "autumnus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; # need unstable for 1.86.0
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      rust-overlay,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rust-ver = pkgs.rust-bin.stable.latest;
      in
      {
        formatter = pkgs.nixfmt-rfc-style;

        packages = rec {
          default = autumnus;

          autumnus = pkgs.callPackage ./nix/package.nix {
            rust = rust-ver.minimal;
          };
        };

        devShells.default = import ./nix/shell.nix {
          inherit pkgs;
          rust = rust-ver.default;
        };
      }
    );
}
