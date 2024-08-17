install:
	# TODO : Add command

switch-theme-nixos: update-theme-var switch-nixos

switch-milkyway: rebuild-milkyway copy-grub-theme

switch-domum-light: rebuild-domum-light copy-grub-theme

switch-domum-dark: rebuild-domum-dark copy-grub-theme

update-flake:
	nix flake update

switch-luna:
	nix run nix-darwin -- switch --flake .#luna --show-trace

update-theme-var:
	./scripts/variable_nix_update.sh

rebuild-milkyway:
	sudo nixos-rebuild switch --flake .#milkyway --show-trace

rebuild-domum-light:
	sudo nixos-rebuild switch --flake .#domum-light --show-trace

rebuild-domum-dark:
	sudo nixos-rebuild switch --flake .#domum-dark --show-trace

copy-grub-theme:
	sudo cp -r -u ./grub/hyperfluent /boot/grub/themes

