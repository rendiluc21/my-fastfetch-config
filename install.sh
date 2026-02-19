#!/bin/bash

# Tentukan lokasi target config
TARGET_DIR="$HOME/.config/fastfetch"
REPO_URL="https://github.com/username_kamu/nama_repo.git"

echo "Updating and installing Fastfetch..."

# Cek apakah Fastfetch sudah terinstall (khusus Arch/CachyOS)
if ! command -v fastfetch &> /dev/null; then
    sudo pacman -S fastfetch --noconfirm
fi

# Backup config lama jika ada
if [ -d "$TARGET_DIR" ]; then
    echo "Backing up existing config..."
    mv "$TARGET_DIR" "$TARGET_DIR.bak"
fi

# Clone repo ke folder sementara lalu pindahkan isinya
echo "Cloning your custom Aether config..."
git clone "$REPO_URL" /tmp/my_fastfetch
mkdir -p "$TARGET_DIR"
cp -r /tmp/my_fastfetch/* "$TARGET_DIR/"

# Hapus file sampah
rm -rf /tmp/my_fastfetch

echo "Done! Sekarang coba ketik 'fastfetch' di terminal."
