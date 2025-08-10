#!/usr/bin/env bash
set -e

# Colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Backup directory
BACKUP_DIR="$HOME/.rice-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup_if_exists() {
    local path="$1"
    if [ -e "$path" ]; then
        echo -e "${YELLOW}Backing up $path -> $BACKUP_DIR${RESET}"
        mkdir -p "$BACKUP_DIR$(dirname "$path")"
        mv "$path" "$BACKUP_DIR$path"
    fi
}

echo -e "${GREEN}==> Installing yay...${RESET}"
sudo pacman -S --needed git base-devel
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
fi

echo -e "${GREEN}==> Installing Oh My Zsh...${RESET}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo -e "${GREEN}==> Installing Powerlevel10k...${RESET}"
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

echo -e "${GREEN}==> Installing pacman packages...${RESET}"
sudo pacman -S --needed - < pkglist-pacman.txt

echo -e "${GREEN}==> Installing yay packages...${RESET}"
yay -S --needed - < pkglist-yay.txt

echo -e "${GREEN}==> Backing up and copying configuration files...${RESET}"
CONFIG_DIR="$HOME/.config"
LOCAL_BIN="$HOME/.local/bin"

mkdir -p "$CONFIG_DIR" "$LOCAL_BIN"

# Backup existing configs
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$CONFIG_DIR/hypr"
backup_if_exists "$CONFIG_DIR/waybar"
backup_if_exists "$CONFIG_DIR/rofi"
backup_if_exists "$HOME/.local/share/rofi"
backup_if_exists "$CONFIG_DIR/swaync"
backup_if_exists "$CONFIG_DIR/swayosd"
backup_if_exists "$CONFIG_DIR/wal"
backup_if_exists "$HOME/.cache/wal"
backup_if_exists "$CONFIG_DIR/spicetify"
backup_if_exists "$CONFIG_DIR/fastfetch"
backup_if_exists "$CONFIG_DIR/kitty"
backup_if_exists "$CONFIG_DIR/cava"
backup_if_exists "$LOCAL_BIN"

# Copy configs
cp -r config/* "$CONFIG_DIR/"
cp -r local-bin/* "$LOCAL_BIN/"
cp .zshrc "$HOME/"

# Restore wal cache
mkdir -p "$HOME/.cache/wal"
cp -r cache-wal/* "$HOME/.cache/wal/"

# Wallpapers with locale awareness
PICTURES_DIR=$(xdg-user-dir PICTURES)
mkdir -p "$PICTURES_DIR/wallpaper"
cp -r wallpapers/* "$PICTURES_DIR/wallpaper/"

echo -e "${GREEN}==> Updating XDG user dirs...${RESET}"
xdg-user-dirs-update

echo -e "${GREEN}Installation complete!${RESET}"
echo -e "${YELLOW}Your previous configuration was backed up to:${RESET} $BACKUP_DIR"

