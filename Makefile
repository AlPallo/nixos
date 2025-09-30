.PHONY: update
update:
	home-manager switch --flake .#alex

.PHONY: clean
clean:
	nix-collect-garbage -d
