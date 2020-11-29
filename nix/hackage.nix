let
  sources = import ./sources.nix {};

  nixpkgs = import ./nixpkgs.nix;

  hackage-info = nixpkgs.lib.importJSON
    (sources.haskell-nix + "/hackage-src.json");

  hackage-src = builtins.fetchTarball {
    inherit (hackage-info) sha256;

    name = "hackage-exprs-source";
    url = "${hackage-info.url}/archive/${hackage-info.rev}.tar.gz";
  };

  index-state-hashes = import (hackage-src + "/index-state-hashes.nix");

  index-date = nixpkgs.lib.last (builtins.attrNames index-state-hashes);
in
index-date