SHELL := /bin/bash
SCRIPT := ./default.sh

default:
	@bash -n $(SCRIPT) || { echo "Syntax error in script"; exit 1; }
	@$(SCRIPT)

pkg:
	@source ./pkgdefs/$(name)/default.sh

sh:
	@find ./pkgdefs/ ./utils/ \( -name "*.sh" -o -name "*.desktop" \) -type f -exec chmod +x {} \;
	@find ./pkgdefs/ -type f -exec touch {} \;

check:
	@./scripts/check_imports.sh;

.PHONY: default pkg sh