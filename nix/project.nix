{ useMaterialization }:
let
  sources = import ./sources.nix {};

  nixpkgs = import ./nixpkgs.nix;

  haskell-nix = import ./haskell-nix.nix;

  index-state = import ./hackage.nix;

  gitignore = import sources.gitignore {
    inherit (nixpkgs) lib;
  };

  materialized = if useMaterialization
    then
      { plan = ./materialized/plan;
        hash = nixpkgs.lib.removeSuffix "\n"
          (builtins.readFile ./materialized/plan-hash.txt);
      }
    else
      { plan = null;
        hash = null;
      }
    ;

  project = haskell-nix.pkgs.haskell-nix.cabalProject {
    name = "maybevoid";
    compiler-nix-name = "ghc8102";

    inherit
      index-state
      useMaterialization
    ;

    src = gitignore.gitignoreSource ../generator;

    plan-sha256 = materialized.hash;
    materialized = materialized.plan;
  };
in
project