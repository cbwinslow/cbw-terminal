#!/bin/bash
# ------------------------------------------------------------------
# Name:        dev-env-installer.sh
# Author:      Blaine Winslow (cbwinslow)
# Date:        2025-04-07
# Purpose:     One-stop script to install a CBW-flavored development
#              environment with hacker theme, tools, aliases, ASCII art,
#              and a Matrix-style welcome. Multi-OS compatible.
# File Path:   ~/cbw-scripts/dev-env-installer.sh
# ------------------------------------------------------------------

set -euo pipefail
IFS=$'\n\t'

LOGFILE="$HOME/dev-env-setup.log"
exec > >(tee -i "$LOGFILE") 2>&1

# -------------------------------
# Functions
# -------------------------------
backup_file() {
  [[ -f $1 ]] && cp "$1" "$1.bak.$(date +%s)"
}

is_command() {
  command -v "$1" >/dev/null 2>&1
}

has_internet() {
  curl -s --head https://google.com | head -n 1 | grep "200 OK" >/dev/null
}

ascii_banner() {
  echo -e "\e[1;32m"
  cat <<'EOF'
   ███╗   ██╗███████╗ ██████╗     ██████╗ ██╗   ██╗██╗███╗   ███╗
   ████╗  ██║██╔════╝██╔═══██╗    ██╔══██╗██║   ██║██║████╗ ████║
   ██╔██╗ ██║█████╗  ██║   ██║    ██████╔╝██║   ██║██║██╔████╔██║
   ██║╚██╗██║██╔══╝  ██║   ██║    ██╔═══╝ ██║   ██║██║██║╚██╔╝██║
   ██║ ╚████║███████╗╚██████╔╝    ██║     ╚██████╔╝██║██║ ╚═╝ ██║
   ╚═╝  ╚═══╝╚══════╝ ╚═════╝     ╚═╝      ╚═════╝ ╚═╝╚═╝     ╚═╝

        Welcome to the MATRIX — Project X3N Init Script
EOF
  echo -e "\e[0m"
}

add_aliases_and_functions() {
  cat <<'EOF' >> "$HOME/.bashrc"

# --- CBW Hacker Aliases ---
alias ll='ls -alF --color=auto'
alias gs='git status'
alias gp='git push'
alias devlog='tail -f ~/dev-env-setup.log'
alias cls='clear && ascii_banner'

# --- CBW Functions ---
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *)           echo "Don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

ascii_banner() {
  echo -e "\e[1;32m"
  echo "   ███╗   ██╗███████╗ ██████╗     ██████╗ ██╗   ██╗██╗███╗   ███╗"
  echo "   ████╗  ██║██╔════╝██╔═══██╗    ██╔══██╗██║   ██║██║████╗ ████║"
  echo "   ██╔██╗ ██║█████╗  ██║   ██║    ██████╔╝██║   ██║██║██╔████╔██║"
  echo "   ██║╚██╗██║██╔══╝  ██║   ██║    ██╔═══╝ ██║   ██║██║██║╚██╔╝██║"
  echo "   ██║ ╚████║███████╗╚██████╔╝    ██║     ╚██████╔╝██║██║ ╚═╝ ██║"
  echo "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝     ╚═╝      ╚═════╝ ╚═╝╚═╝     ╚═╝"
  echo -e "\e[0m"
}
EOF
}

install_tools() {
  echo "[+] Installing development tools..."

  if is_command apt; then
    sudo apt update && sudo apt install -y \
      git curl wget neovim tmux build-essential python3 python3-pip unzip \
      fonts-hack-ttf htop net-tools bat figlet lolcat jq fzf

  elif is_command dnf; then
    sudo dnf install -y \
      git curl wget neovim tmux @development-tools python3 python3-pip unzip \
      terminus-fonts htop net-tools bat figlet lolcat jq fzf

  elif is_command pacman; then
    sudo pacman -Sy --noconfirm \
      git curl wget neovim tmux base-devel python python-pip unzip \
      ttf-hack htop net-tools bat figlet lolcat jq fzf
  fi
}

apply_hacker_theme() {
  echo "[+] Applying hacker theme..."

  backup_file "$HOME/.bashrc"
  add_aliases_and_functions

  echo "export EDITOR=nvim" >> "$HOME/.bashrc"
  echo "alias matrix='cmatrix -b -u 2'" >> "$HOME/.bashrc"

  ascii_banner
}

final_message() {
  echo "[✔] CBW dev environment is ready! Restart your terminal."
  echo "[i] Type 'matrix' for the Matrix rain. Type 'cls' to show your banner."
}

# -------------------------------
# Main Execution
# -------------------------------

if ! has_internet; then
  echo "[-] Internet connection is required. Exiting."
  exit 1
fi

install_tools
apply_hacker_theme
final_message
