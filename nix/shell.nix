{
  pkgs,
  rust,
}:
let
  basePackages = with pkgs; [
    rust
    rust-analyzer
  ];

  inputs = with pkgs; basePackages ++ lib.optionals stdenv.isLinux [ inotify-tools ];
in
pkgs.mkShell {
  name = "autumnus";
  buildInputs = inputs;
}
