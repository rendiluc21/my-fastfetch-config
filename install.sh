#!/bin/bash

# --- KONFIGURASI ---
USER="rendiluc21" # <--- GANTI INI
REPO="my-fastfetch-config"
TARGET_DIR="$HOME/.config/fastfetch"

echo "--- Memulai Setup Aether ---"

# 1. Install Dependencies
echo "Installing fastfetch & starship..."
sudo pacman -S --noconfirm fastfetch starship curl

# 2. Setup Starship Preset
echo "Applying Starship Pastel Powerline..."
mkdir -p ~/.config
starship preset pastel-powerline -o ~/.config/starship.toml

# 3. Download Config Fastfetch (Langsung ambil file, bukan git clone)
echo "Downloading config.jsonc..."
mkdir -p "$TARGET_DIR"
curl -sSL "https://raw.githubusercontent.com/$USER/$REPO/main/config.jsonc" -o "$TARGET_DIR/config.jsonc"

echo "----------------------------------------"
echo "SELESAI! Coba ketik 'fastfetch'."
echo "Jika starship belum muncul, tambah baris ini di config shellmu:"
echo "starship init fish | source  (untuk fish)"
echo "----------------------------------------"
