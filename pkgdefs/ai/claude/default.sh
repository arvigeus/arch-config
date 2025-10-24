#!/bin/bash

paru -S --noconfirm --needed claude-code claudia
mkdir -p "$HOME/.claude"
# https://docs.anthropic.com/en/docs/claude-code/settings
cp -u -p ./pkgdefs/ai/claude/settings.json "$HOME/.claude/settings.json"

mkdir -p "$HOME/.claude/commands"
cp -u -p ./pkgdefs/ai/claude/commands/commit.md "$HOME/.claude/commands/commit.md"