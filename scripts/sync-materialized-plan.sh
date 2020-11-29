#!/usr/bin/env bash

set -euxo pipefail

plan=$(nix-build --no-out-link nix/plan.nix)

rm -rf nix/materialized

cp -r $plan nix/materialized

find nix/materialized -type d -exec chmod 755 {} \;
