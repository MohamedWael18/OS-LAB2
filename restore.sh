#!/bin/bash

TARGET_DIR="${1%/}"
MALICIOUS_DIR="${2%/}"
while true; do
    if [ -z "$(ls -A "$MALICIOUS_DIR")" ]; then
        echo "No malicious files to review. Exiting."
        break
    fi
    files=()
    i=1
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            files+=("$file")
            echo "  $i) $file"
            ((i++))
        fi
    done < <(ls -1 "$MALICIOUS_DIR")
    read -p "Select a file by number to manage: " selection
    if [[ "$selection" == "0" ]]; then
        echo "Exiting recovery tool."
        break
    fi

    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "${#files[@]}" ]; then
        echo "Invalid choice. Please pick a number from the list."
        continue
    fi
    chosen_file="${files[$((selection - 1))]}"
    src_filepath="$MALICIOUS_DIR/$chosen_file"
    dest_filepath="$TARGET_DIR/$chosen_file"

    echo "Managing file: $chosen_file"
    echo "  1) Restore this file back to $TARGET_DIR"
    echo "  2) Permanently delete this file"
    echo "  3) Leave file as-is (Go back)"
    read -p "Choose option (1-3): " action
    case "$action" in
        1)
            mv "$src_filepath" "$dest_filepath"
            echo "Restored $chosen_file to $TARGET_DIR."
            ;;
        2)
            rm -f "$src_filepath"
            echo "$chosen_file permanently deleted."
            ;;
        3)
            echo "Skipping file."
            ;;
        *)
            echo "Invalid selection. Returning to list view."
            ;;
    esac
done

