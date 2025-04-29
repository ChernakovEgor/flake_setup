.PHONY: update clean

update:
	home-manager switch --flake .#lab

clean:
	nix-collect-garbage -d
