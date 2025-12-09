#!/bin/bash

source ./utils/create_web_app.sh

create_web_app "ChatGPT" "https://chatgpt.com/?temporary-chat=true"
create_web_app "Claude" "https://claude.ai/new"
create_web_app "Le Chat" "https://chat.mistral.ai/chat"
create_web_app "Gemini" "https://gemini.google.com/app"

source ./pkgdefs/ai/claude/default.sh

flatpak install -y flathub ai.jan.Jan

flatpak install -y org.upscayl.Upscayl
