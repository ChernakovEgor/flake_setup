.PHONY: update clean

update:
	home-manager switch --flake .#desktop

clean:
	nix-collect-garbage -d
