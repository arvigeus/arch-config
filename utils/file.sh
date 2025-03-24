#!/bin/bash

file_add_line() {
    local line="$1"
    local file="$2"

    # Ensure the file exists before doing anything
    touch "$file"

    # Check if the exact line exists
    if ! grep -Fxq -- "$line" "$file"; then
        echo "$line" >>"$file"
    fi
}
