#!/bin/bash

SEARCH_DIR="$HOME"
ASCII_DIR=$(find "$SEARCH_DIR" -type d -name "waifuu" 2>/dev/null | head -n 1)

if [[ -z "$ASCII_DIR" ]]; then
    echo "No directory found."
    exit 1
fi

# reall all ascii txts
ASCII_FILES=($(find "$ASCII_DIR" -type f -name "*.txt" -exec test -e {} \; -print))


if [[ ${#ASCII_FILES[@]} -eq 0 ]]; then
    echo "No ASCII art files found in '$ASCII_DIR'."
    exit 1
fi

# random ascii 
RANDOM_FILE="${ASCII_FILES[RANDOM % ${#ASCII_FILES[@]}]}"

# sys infos
HOSTNAME=$(hostname)
OS=$(grep "^PRETTY_NAME=" /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p | cut -d " " -f2-)
SHELL=$(basename "$SHELL")
MEMORY=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2- | sed 's/^ *//')

clear

# print
cat "$RANDOM_FILE"

# show sys info 
echo -e "\n\033[1;34m$USER@$HOSTNAME\033[0m"
echo -e "----------------------"
echo -e "\033[1;32mOS:\033[0m $OS"
echo -e "\033[1;32mKernel:\033[0m $KERNEL"
echo -e "\033[1;32mUptime:\033[0m $UPTIME"
echo -e "\033[1;32mShell:\033[0m $SHELL"
echo -e "\033[1;32mCPU:\033[0m $CPU"
echo -e "\033[1;32mMemory:\033[0m $MEMORY"

