#!/usr/bin/env bash
set -ex

VIMEXE=nvim

install_plugins() {
    bash <<EOF
set -e
pushd ~/
    mkdir -p ~/.config/coc/extensions/node_modules/coc-ccls
    ln -sf node_modules/ws/lib ~/.config/coc/extensions/node_modules/coc-ccls/lib
    echo "-- Start installing plugins"
    $VIMEXE --headless -c 'sleep 5' -c qa
    $VIMEXE --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    $VIMEXE --headless -c 'sleep 10' -c 'CocUpdateSync' -c 'TSUpdateSync' -c qa 
    echo '-- Plugins installed successfully'
popd
EOF
}

install_vimrc() {
    if [ -d ~/.config/nvim ]; then
        echo "-- backup existing nvim config"
        mv ~/.config/nvim ~/.config/nvim.backup$$
        rm -rf ~/.local/share/nvim
        rm -rf ~/.config/coc
    fi
    git clone https://github.com/badawsome/nv.git ~/.config/nvim
}

install_pacman() {
    sudo pacman -S --noconfirm fzf ripgrep nodejs ccls glibc lib32-glibc

    install_vimrc
    install_plugins
}

install_brew() {
    brew install fzf ripgrep 
    brew install cmake make gcc curl
    brew install node ccls

    install_vimrc
    install_plugins
}

get_linux_distro() {
    if grep -Eq "Ubuntu" /etc/*-release; then
        echo "Ubuntu"
    elif grep -Eq "Deepin" /etc/*-release; then
        echo "Deepin"
    elif grep -Eq "Raspbian" /etc/*-release; then
        echo "Raspbian"
    elif grep -Eq "uos" /etc/*-release; then
        echo "UOS"
    elif grep -Eq "LinuxMint" /etc/*-release; then
        echo "LinuxMint"
    elif grep -Eq "elementary" /etc/*-release; then
        echo "elementaryOS"
    elif grep -Eq "Debian" /etc/*-release; then
        echo "Debian"
    elif grep -Eq "Kali" /etc/*-release; then
        echo "Kali"
    elif grep -Eq "Parrot" /etc/*-release; then
        echo "Parrot"
    elif grep -Eq "CentOS" /etc/*-release; then
        echo "CentOS"
    elif grep -Eq "fedora" /etc/*-release; then
        echo "fedora"
    elif grep -Eq "openSUSE" /etc/*-release; then
        echo "openSUSE"
    elif grep -Eq "Arch Linux" /etc/*-release; then
        echo "ArchLinux"
    elif grep -Eq "ManjaroLinux" /etc/*-release; then
        echo "ManjaroLinux"
    elif grep -Eq "Gentoo" /etc/*-release; then
        echo "Gentoo"
    elif grep -Eq "alpine" /etc/*-release; then
        echo "Alpine"
    elif [ "x$(uname -s)" == "xDrawin" ]; then
        echo "MacOS"
    else
        echo "Unknown"
    fi
}

distro=`get_linux_distro`
echo "-- Linux distro detected: $distro"
if [ $distro == "ArchLinux" ] || [ $distro == "ManjaroLinux" ]; then
    install_pacman
elif [ $distro == "MacOS" ]; then
    install_brew
else
    echo "System Not Supported, exit"
    exit 255
fi

