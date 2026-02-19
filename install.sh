#!/bin/bash

# --- KONFIGURASI ---
USER="rendiluc21"
REPO="my-fastfetch-config"
TARGET_DIR="$HOME/.config/fastfetch"

echo "--- Memulai Setup Fastfetch & Starship ---"

# 1. Install Dependencies
echo "Installing fastfetch & starship..."
sudo pacman -S --noconfirm fastfetch starship curl

# 2. Setup Starship Preset
echo "Applying Starship Pastel Powerline..."
mkdir -p ~/.config
"$HOME/.cargo/bin/starship" preset pastel-powerline -o ~/.config/starship.toml || {
    echo "Warning: Starship preset setup may need manual configuration"
}

# 3. Download Config Fastfetch
echo "Downloading config.jsonc..."
mkdir -p "$TARGET_DIR"

# Try with authentication token if available, otherwise use public access
if [ -n "$GITHUB_TOKEN" ]; then
    curl -sSL -H "Authorization: token $GITHUB_TOKEN" \
        "https://api.github.com/repos/$USER/$REPO/contents/config.jsonc" \
        -o "$TARGET_DIR/config.jsonc" || \
    curl -sSL "https://raw.githubusercontent.com/$USER/$REPO/main/config.jsonc" \
        -o "$TARGET_DIR/config.jsonc"
else
    curl -sSL "https://raw.githubusercontent.com/$USER/$REPO/main/config.jsonc" \
        -o "$TARGET_DIR/config.jsonc"
fi

# Verify download
if [ -f "$TARGET_DIR/config.jsonc" ]; then
    echo "✓ Config downloaded successfully!"
else
    echo "✗ Failed to download config. Check if the repository is public or set GITHUB_TOKEN"
    exit 1
fi

echo "----------------------------------------"
echo "SELESAI! Coba ketik 'fastfetch'."
echo "Jika starship belum muncul, tambah baris ini di ~/.bashrc atau ~/.config/fish/config.fish:"
echo "eval \"\$(starship init bash)\"  (untuk bash)"
echo "starship init fish | source      (untuk fish)"
echo "----------------------------------------"
