SHELL := /bin/bash
SCRIPT := ./default.sh

default:
	@bash -n $(SCRIPT) || { echo "Syntax error in script"; exit 1; }
	@$(SCRIPT)

pkg:
	@./pkgdefs/$(name)/default.sh

sh:
	@find ./pkgdefs/ -type f -name "*.sh" -exec chmod +x {} \;

.PHONY: default pkg sh