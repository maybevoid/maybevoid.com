#!/usr/bin/env bash

set -euxo pipefail

releases=(
  default.nix
  nix/plan.nix
  nix/project-shell.nix
)

for release in "${releases[@]}"
do
  nix-store -qR --include-outputs $(nix-instantiate $release) \
    | cachix push maybevoid
done