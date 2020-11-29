let
  nixpkgs = import ./nixpkgs.nix;

  project = import ./project.nix {
    useMaterialization = false;
  };
in
nixpkgs.stdenv.mkDerivation {
  name = "materialized-plan";
  phases = [ "installPhase" ];
  buildInputs = [ nixpkgs.nix ];
  installPhase = ''
    mkdir -p $out
    cp -r ${project.plan-nix} $out/plan
    nix-hash --base32 --type sha256 $out/plan/ > $out/plan-hash.txt
  '';
}
