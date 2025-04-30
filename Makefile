.PHONY: update clean

update:
	home-manager switch --flake .

clean:
	nix-collect-garbage -d
