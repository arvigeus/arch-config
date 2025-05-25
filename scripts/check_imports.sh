#!/usr/bin/env bash

set -euo pipefail

IMPORT_FILE="./default.sh"  # Change if different

# Extract sourced paths from import.sh
mapfile -t sourced_paths < <(grep -E '^source +\./pkgdefs/.+/default\.sh' "$IMPORT_FILE" | sed -E 's|^source +||')

# Normalize to folder names
declare -A sourced_folders
for path in "${sourced_paths[@]}"; do
  folder=$(echo "$path" | cut -d'/' -f3)
  sourced_folders["$folder"]=1
done

# Actual folders present
mapfile -t actual_folders < <(find ./pkgdefs -mindepth 1 -maxdepth 1 -type d -printf '%f\n')

# Check for missing imports
echo "🔍 Checking for missing or extra imports..."
missing=()
extra=()

for folder in "${actual_folders[@]}"; do
  if [[ -f "./pkgdefs/$folder/default.sh" && -z "${sourced_folders[$folder]+set}" ]]; then
    missing+=("$folder")
  fi
done

for folder in "${!sourced_folders[@]}"; do
  if [[ ! -d "./pkgdefs/$folder" ]]; then
    extra+=("$folder")
  fi
done

if ((${#missing[@]})); then
  echo "❌ Missing imports:"
  for f in "${missing[@]}"; do
    echo "  source ./pkgdefs/$f/default.sh"
  done
else
  echo "✅ All existing folders are imported."
fi

if ((${#extra[@]})); then
  echo "⚠️ Imported folders that do not exist:"
  for f in "${extra[@]}"; do
    echo "  $f"
  done
fi
