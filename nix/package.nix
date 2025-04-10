{
  pkgs,
  rust,
  ...
}:
let
  rustPlatform = pkgs.makeRustPlatform {
    cargo = rust;
    rustc = rust;
  };

  cargoToml = builtins.fromTOML (builtins.readFile ../Cargo.toml);
  version = cargoToml.package.version;
in
rustPlatform.buildRustPackage {
  pname = "autumnus";
  inherit version;
  src = ../.;
  cargoLock.lockFile = ../Cargo.lock;
}
