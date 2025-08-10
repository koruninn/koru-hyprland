#!/usr/bin/env bash
set -e

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

if [ $# -ne 1 ]; then
    echo -e "${YELLOW}Usage:${RESET} $0 <backup-folder>"
    echo "Example: $0 ~/.rice-backup-20250810-153045"
    exit 1
fi

BACKUP_DIR="$1"

if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Error:${RESET} Backup folder not found."
    exit 1
fi

echo -e "${GREEN}==> Restoring configs from $BACKUP_DIR...${RESET}"

# Restore each file/folder in backup
find "$BACKUP_DIR" -mindepth 1 | while read -r item; do
    REL_PATH="${item#$BACKUP_DIR}"
    TARGET="$REL_PATH"

    # Remove any existing file/folder at target
    if [ -e "$TARGET" ]; then
        echo -e "${YELLOW}Removing current $TARGET before restore...${RESET}"
        rm -rf "$TARGET"
    fi

    # Create parent directories if needed
    mkdir -p "$(dirname "$TARGET")"

    # Move from backup to target
    mv "$item" "$TARGET"
done

echo -e "${GREEN}Restoration complete!${RESET}"

echo -e "${GREEN}==> Removing installed packages...${RESET}"
sudo pacman -Rns --noconfirm $(cat pkglist-pacman.txt)
yay -Rns --noconfirm $(cat pkglist-yay.txt)

echo -e "${GREEN}==> Optionally removing oh-my-zsh and powerlevel10k...${RESET}"
rm -rf ~/.oh-my-zsh
