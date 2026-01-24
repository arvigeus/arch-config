#!/bin/bash

# claude plugin marketplace add <org>/<marketplace-name>
# claude plugin install <plugin-name>@<marketplace-name>

claude plugin marketplace add anthropics/claude-plugins-official
claude plugin marketplace add katawaredev/kataware-claude-plugins

claude plugin install typescript-lsp@claude-plugins-official
# TypeScript/JavaScript language server.
# Provides: Go-to-definition, find references, error checking for .ts, .tsx, .js, .jsx.
# Requirement: npm install -g typescript-language-server typescript
sudo pacman -S --noconfirm --needed typescript-language-server 
      
claude plugin install rust-analyzer-lsp@claude-plugins-official
# Rust language server.
# Provides: Code intelligence and analysis for .rs files.
# Requirement: rust-analyzer binary (via rustup, brew, or package manager).
sudo pacman -S --noconfirm --needed rust-analyzer
      
claude plugin install csharp-lsp@claude-plugins-official
# C# language server.
# Provides: Code intelligence and diagnostics for .cs files.
# Requirement: dotnet tool install --global csharp-ls
paru -S --noconfirm --needed omnisharp-roslyn
      
claude plugin install frontend-design@claude-plugins-official
# Generates distinctive, production-grade frontend interfaces.
# Usage: Automatically triggers on frontend tasks.
# Prompts: "Create a dashboard...", "Design a landing page..."
      
claude plugin install github@claude-plugins-official
# Integration with GitHub for repository management.
      
claude plugin install context7@claude-plugins-official
# Context7 documentation and library resolution tool.
# Used to fetch up-to-date docs and code examples for libraries.
      
claude plugin install code-review@claude-plugins-official
# Automated PR review with multiple specialized agents.
# Command: /code-review (Runs on current branch/PR)
# Features: Checks CLAUDE.md compliance, bugs, and history. Filters false positives (confidence < 80).
      
claude plugin install feature-dev@claude-plugins-official
# Guided 7-phase feature development workflow.
# Command: /feature-dev "Add user auth" (or just /feature-dev)
# Workflow: Discovery -> Explore Code -> Questions -> Architecture -> Implement -> Review -> Summary.
      
claude plugin install commit-commands@claude-plugins-official
# Git workflow automation.
# Commands:
#   /commit - Stage & commit with auto-generated message based on style.
#   /commit-push-pr - Commit, push, and create PR in one step.
#   /clean_gone - Delete local branches merged/deleted on remote.
      
claude plugin install playwright@claude-plugins-official
# Playwright browser testing and automation support.
# Likely enables running and writing Playwright tests efficiently.
      
claude plugin install security-guidance@claude-plugins-official
# Real-time security hook.
# Action: Warns about command injection, XSS, and unsafe patterns during file edits.
      
claude plugin install code-simplifier@claude-plugins-official
# Refines code for clarity and maintainability without changing behavior.
# Focus: Recently modified code.
# Usage: Ask Claude to "simplify this code" or "run code simplifier".
      
claude plugin install ralph-loop@claude-plugins-official
# Iterative, self-correcting development loop.
# Command: /ralph-loop "Task description" --max-iterations 50 --completion-promise "DONE"
# Usage: For complex tasks requiring repeated trial/error (e.g., passing tests).
# Stop: /cancel-ralph
      
claude plugin install hookify@claude-plugins-official
# Create custom behavioral rules/hooks via Markdown.
# Commands:
#   /hookify "Warn me when I use rm -rf" (Creates a new rule)
#   /hookify:list (List rules)
#   /hookify:configure (Enable/disable rules)
      
claude plugin install superpowers@claude-plugins-official
# A complete software development workflow: Brainstorm -> Plan -> Execute.
# Commands:
#   /superpowers:brainstorm - Interactive design refinement.
#   /superpowers:write-plan - Create detailed implementation plan.
#   /superpowers:execute-plan - Execute plan in batches.
# Features: Enforces TDD, systematic debugging, and sub-agent driven development.