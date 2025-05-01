.PHONY: update clean nixos

update:
	home-manager switch --flake .

nixos:
	nixos-rebuild switch --use-remote-sudo

clean:
	nix-collect-garbage -d
