SHELL := /bin/bash
SCRIPT := ./default.sh

default:
	@bash -n $(SCRIPT) || { echo "Syntax error in script"; exit 1; }
	@$(SCRIPT)

pkg:
	@source ./utils/default.sh && ./pkgdefs/$(name)/default.sh

sh:
	@find ./pkgdefs/ ./utils/ -type f -name "*.sh" -exec chmod +x {} \;
	@find ./pkgdefs/ -type f -exec touch {} \;

.PHONY: default pkg sh