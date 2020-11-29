release:
	nix-build -j4 .

cachix:
	./scripts/cachix.sh

watch:
	nix-shell --pure --run "generate-site watch --host 0.0.0.0"

clean:
	rm -f result
	rm -rf hakyll-cache site-dist

sync-materialized-plan:
	./scripts/sync-materialized-plan.sh

.PHONY: clean release cachix watch \
	sync-materialized-plan
