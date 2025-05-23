#!/usr/bin/bash

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
NC="$(tput sgr0)"
CURL_VIMRC_CMD="curl -O https://raw.githubusercontent.com/Extr3m4R4710/dotfile/main/vimrc/.vimrc"

function ascii_banner()
{
  echo -e "$GREEN    _____   ____________   __ __ ___    __    ____$NC"
  echo -e "$GREEN   /  _/ | / /  _/_  __/  / //_//   |  / /   /  _/$NC"
  echo -e "$GREEN   / //  |/ // /  / /    / ,<  / /| | / /    / /$NC"
  echo -e "$GREEN _/ // /|  // /  / /    / /| |/ ___ |/ /____/ /$NC"
  echo -e "$GREEN/___/_/ |_/___/ /_/    /_/ |_/_/  |_/_____/___/$NC"

}

function init_live_kali()
{
    apt update && apt install riseup-vpn ibus-mozc tor keepassxc gpg sn0int proxychains-ng
    $CURL_VIMRC_CMD && cp -v "$(pwd)/.vimrc" ~/.vimrc && mv -v $(pwd)/.vimrc /home/kali

    for zshrc in /home/kali/.zshrc /root/.zshrc; do
        if ! grep -q 'export EDITOR="vim"' "$zshrc"; then
            echo -e "${GREEN}[+]${NC} Add EDITOR="vim" into $zshrc"
            echo 'export EDITOR="vim"' >> "$zshrc"
        else
            echo -e "${GREEN}[+]${NC} EDITOR="vim" is already set in $zshrc"
        fi
    done
}

function main()
{
    cp -v ./etc/resolv.conf /etc/
    cp -v ./etc/environment /etc/
    systemctl start tor


    if [[ $EUID -eq 0 ]]; then
        ascii_banner
        init_live_kali
        if [[ -d "$(pwd)/script_vox" ]]; then
            echo "$GREEN[+]$NC directory is exists. G4m3 2e7"
        else
            echo "$GREEN[+]$NC install the script_vox"
            git clone --recursive https://github.com/NzxSec/script_vox
            cd script_vox
            git submodule update --remote

        fi
    else
        echo -e "$RED [X] ERROR: YOU MOUST BE ROOT"
        exit 1
    fi
}

#run main function
main
