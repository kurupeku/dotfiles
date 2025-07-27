#!/bin/bash

# Constants definition
readonly DOTPATH="${HOME}/dotfiles"
readonly SCRIPTSPATH="${DOTPATH}/modules/scripts"
readonly DOTFILES_REPO="https://github.com/kurupeku/dotfiles.git"
readonly DOTFILES_ARCHIVE="https://github.com/kurupeku/dotfiles/archive/main.tar.gz"
readonly SUPPORTED_OS='Darwin'
readonly TMPDIR="/tmp/dotfiles_install"

# Error handling function
die() {
    echo "Error: $1" >&2
    exit 1
}

# Download using curl
download_with_curl() {
    echo "Downloading with curl..."
    mkdir -p "$TMPDIR"
    if ! curl -L "$DOTFILES_ARCHIVE" -o "${TMPDIR}/dotfiles.tar.gz"; then
        rm -rf "$TMPDIR"
        die "Failed to download with curl"
    fi
}

# Download using wget
download_with_wget() {
    echo "Downloading with wget..."
    mkdir -p "$TMPDIR"
    if ! wget -O "${TMPDIR}/dotfiles.tar.gz" "$DOTFILES_ARCHIVE"; then
        rm -rf "$TMPDIR"
        die "Failed to download with wget"
    fi
}

# Extract downloaded archive
extract_archive() {
    echo "Extracting archive..."
    if ! tar xzf "${TMPDIR}/dotfiles.tar.gz" -C "$TMPDIR"; then
        rm -rf "$TMPDIR"
        die "Failed to extract archive"
    fi
    mv "${TMPDIR}/dotfiles-main" "$DOTPATH"
    rm -rf "$TMPDIR"
    echo "Successfully extracted dotfiles"
}

# Clone or download dotfiles repository
clone_dotfiles() {
    if [ ! -e "$DOTPATH" ]; then
        echo "Fetching dotfiles repository..."

        if type "git" >/dev/null 2>&1; then
            echo "Using git..."
            if ! git clone --recursive "$DOTFILES_REPO" "$DOTPATH"; then
                die "Failed to clone repository"
            fi
        elif type "curl" >/dev/null 2>&1; then
            download_with_curl
            extract_archive
        elif type "wget" >/dev/null 2>&1; then
            download_with_wget
            extract_archive
        else
            die "Either git, curl, or wget is required"
        fi

        echo "Successfully fetched dotfiles"
    fi
}

# Check OS and install packages
setup_packages() {
    local kernel
    kernel=$(uname)

    if [ "$kernel" != "$SUPPORTED_OS" ]; then
        die "Currently supports MacOS only"
    fi

    . "${SCRIPTSPATH}/mac_packages_install.sh"
}

# Setup mise and development tools
setup_mise() {
    . "${SCRIPTSPATH}/mise_setup.sh"
}

# Main process
main() {
    clone_dotfiles
    . "${SCRIPTSPATH}/sym_link_config.sh"
    setup_packages
    setup_mise
    echo "All processes completed successfully"
    exec "$SHELL" -l
}

main
