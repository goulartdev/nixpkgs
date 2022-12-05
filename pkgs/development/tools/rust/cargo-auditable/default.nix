{ lib, fetchFromGitHub, makeRustPlatform, rustc, cargo }:

let
  args = rec {
    pname = "cargo-auditable";
    version = "0.5.5";

    src = fetchFromGitHub {
      owner = "rust-secure-code";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-mEmTgd7sC2jmYeb5pEO985v/aWWKlq/mSQUAGi32loY=";
    };

    cargoSha256 = "sha256-G72UUqvFaTY/GQSkpz1wIzjb7vIWuAjvKMZosUB6YsA=";

    meta = with lib; {
      description = "A tool to make production Rust binaries auditable";
      homepage = "https://github.com/rust-secure-code/cargo-auditable";
      changelog = "https://github.com/rust-secure-code/cargo-auditable/blob/v${version}/cargo-auditable/CHANGELOG.md";
      license = with licenses; [ mit /* or */ asl20 ];
      maintainers = with maintainers; [ figsoda ];
    };
  };

  rustPlatform = makeRustPlatform {
    inherit rustc;
    cargo = cargo.override {
      auditable = false;
    };
  };

  bootstrap = rustPlatform.buildRustPackage (args // {
    auditable = false;
  });
in

rustPlatform.buildRustPackage.override { cargo-auditable = bootstrap; } (args // {
  auditable = true; # TODO: remove when this is the default
})
