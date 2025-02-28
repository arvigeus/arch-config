#!/bin/bash

file_add_line() {
    local line="$1"
    local file="$2"

    # Ensure the file exists before doing anything
    touch "$file"

    # Escape special characters for grep (using printf for safety)
    local escaped_line
    escaped_line=$(printf "%s\n" "$line" | sed 's/[.[\*^$]/\\&/g')

    # Check if the exact line exists
    if ! grep -Fxq -- "$escaped_line" "$file"; then
        echo "$line" >> "$file"
    fi
}