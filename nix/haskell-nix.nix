let
  sources = import ./sources.nix {};

  haskell-nix = import sources.haskell-nix {};
in
haskell-nix