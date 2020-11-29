let
  nixpkgs = import ./nixpkgs.nix;

  project = import ./project.nix {
    useMaterialization = true;
  };

  generator = project.maybevoid.components.exes.generate-site;
in
  nixpkgs.stdenv.mkDerivation {
    name = "maybevoid-website";
    src = ../site;

    buildInputs = [
      generator
      nixpkgs.coreutils
      nixpkgs.glibcLocales
    ];

    LANG = "en_US.UTF-8";

    buildCommand = ''
      cp -r $src site/
      generate-site build
      cp -r site-dist/ $out/
    '';
  }