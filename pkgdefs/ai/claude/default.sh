#!/bin/bash

paru -S --noconfirm --needed claude-code
mkdir -p "$HOME/.claude"
# https://docs.anthropic.com/en/docs/claude-code/settings
cp -u -p ./pkgdefs/ai/claude/settings.json "$HOME/.claude/settings.json"

source ./pkgdefs/ai/claude/plugins.sh
source ./pkgdefs/ai/claude/skills.sh