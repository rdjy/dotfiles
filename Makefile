build:
	home-manager -I ${HOME}/3 -f home.nix build
install:
	home-manager -I ${HOME}/3 -f home.nix switch

.PHONY: build
