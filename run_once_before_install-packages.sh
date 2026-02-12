#!/bin/bash

# Exit on error
set -e

echo "🚀 Starting Arch environment setup..."

# --- 1. Update System & Install Build Essentials ---
echo "📦 Updating system and installing base dependencies..."
sudo pacman -Syu --noconfirm --needed git base-devel meson ninja

# --- 2. Install Official Packages ---
echo "📦 Installing official repo applications..."
OFFICIAL_APPS=(
    7zip alacritty alsa-utils cmake dmenu dunst fastfetch fd
    gpicview htop i3-wm i3blocks i3lock i3status impala
    lxappearance lxappearance-obconf lxde-common lxde-icon-theme lxdm
    lxhotkey lxinput lxlauncher lxmusic lxpanel lxrandr lxsession
    lxtask lxterminal ly maim man-db mesa nano neovim
    openbox pacman-contrib pavucontrol pcmanfm pipewire pipewire-pulse
    playerctl polybar ripgrep rofi rofi-calc sof-firmware spotify-launcher
    thunar ttf-iosevka-nerd uthash wireplumber wmctrl xclip xdotool
    xf86-video-intel xorg-server xorg-xinit xorg-xinput xorg-xrandr
    xorg-xset xwallpaper yazi
)
sudo pacman -S --noconfirm --needed "${OFFICIAL_APPS[@]}"

# --- 3. Install Yay (AUR Helper) ---
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
else
    echo "✅ Yay is already installed."
fi

# --- 4. Install the r0-zero Picom Fork ---
# Building from source ensures you keep those specific animations
echo "🎨 Building and installing r0-zero picom fork..."
if [ -d "/tmp/picom-build" ]; then rm -rf /tmp/picom-build; fi
git clone https://github.com/r0-zero/picom.git /tmp/picom-build
cd /tmp/picom-build
meson setup --buildtype=release build
ninja -C build
sudo ninja -C build install
cd -

# --- 5. Apply Configs via Chezmoi ---
#if ! command -v chezmoi &> /dev/null; then
#   echo "🏠 Installing chezmoi..."
#   sudo pacman -S --noconfirm chezmoi
#fi

#echo "🔗 Applying dotfiles..."
#chezmoi init --apply https://github.com/prolinuxgamer420/dotfiles.git

echo "✨ All done! Log out or restart i3 to enjoy your setup."
