#!/bin/bash

## Essentials
code --install-extension mikestead.dotenv
code --install-extension editorconfig.editorconfig
## Interface Improvements
code --install-extension eamodio.gitlens
code --install-extension usernamehw.errorlens
code --install-extension pflannery.vscode-versionlens
code --install-extension yoavbls.pretty-ts-errors
code --install-extension wix.vscode-import-cost
code --install-extension gruntfuggly.todo-tree
## Color schemes
### "workbench.colorTheme": "One Dark Pro Flat"
code --install-extension zhuangtongfa.material-theme
### "workbench.colorTheme": "Adwaita Dark & Github syntax highlighting",
code --install-extension egirlcatnip.adwaita-github-theme
### Fixes the theme colors
sed -i 's/#242424/#262626/g' "$HOME/.vscode-oss/extensions/egirlcatnip.adwaita-github-theme*/themes/adwaita-dark-github.json"
## Web Dev
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension csstools.postcss
code --install-extension stylelint.vscode-stylelint
code --install-extension bradlc.vscode-tailwindcss
code --install-extension davidanson.vscode-markdownlint
code --install-extension unifiedjs.vscode-mdx
# Deno
code --install-extension denoland.vscode-deno
## GraphQL
code --install-extension graphql.vscode-graphql-syntax
code --install-extension graphql.vscode-graphql
## Bash
code --install-extension mads-hartmann.bash-ide-vscode
code --install-extension mkhl.shfmt
## Testing
code --install-extension vitest.explorer
code --install-extension ms-playwright.playwright
code --install-extension firefox-devtools.vscode-firefox-debug
code --install-extension ms-vscode.test-adapter-converter