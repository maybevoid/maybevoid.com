let
  project = import ./project.nix {
    useMaterialization = true;
  };

  shell = project.shellFor {
    packages = hsPkgs: [
      hsPkgs.maybevoid
    ];

    withHoogle = false;
  };
in
shell