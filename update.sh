#!/bin/bash

set -e

# Constants definition  
readonly DOTPATH="${HOME}/dotfiles"
readonly SCRIPTSPATH="${DOTPATH}/modules/scripts"
readonly SUPPORTED_OS='Darwin'

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# ログ出力用の関数
log() {
    echo -e "${GREEN}🔄 $1${NC}"
}

warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
}

# Error handling function
die() {
    error "$1"
    exit 1
}

# Check if we're in the dotfiles directory
check_dotfiles_directory() {
    if [ ! -d "$DOTPATH" ]; then
        die "Dotfiles directory not found at $DOTPATH. Please run install.sh first."
    fi
    
    if [ ! -f "$DOTPATH/install.sh" ]; then
        die "This doesn't appear to be a valid dotfiles directory."
    fi
}

# Check OS compatibility
check_os() {
    local kernel
    kernel=$(uname)
    
    if [ "$kernel" != "$SUPPORTED_OS" ]; then
        die "Currently supports macOS only"
    fi
}

# Re-create symbolic links
update_symlinks() {
    log "Updating symbolic links..."
    if [ -f "${SCRIPTSPATH}/sym_link_config.sh" ]; then
        . "${SCRIPTSPATH}/sym_link_config.sh"
        log "Symbolic links updated successfully"
    else
        error "sym_link_config.sh not found"
        return 1
    fi
}

# Update packages
update_packages() {
    log "Updating packages..."
    
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        warn "Homebrew not found. Installing Homebrew first..."
        . "${SCRIPTSPATH}/mac_packages_install.sh"
        return 0
    fi
    
    # Update Homebrew itself
    log "Updating Homebrew..."
    brew update
    
    # Upgrade all installed packages
    log "Upgrading CLI packages..."
    brew upgrade
    
    log "Upgrading GUI applications..."
    brew upgrade --cask --greedy
    
    # Install any new packages that might have been added
    log "Installing any new packages..."
    . "${SCRIPTSPATH}/mac_packages_install.sh"
    
    # Clean up
    log "Cleaning up..."
    brew cleanup
    
    log "Package update completed successfully"
}

# Show usage information
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Update dotfiles configuration and packages"
    echo ""
    echo "OPTIONS:"
    echo "  -s, --symlinks-only    Update symbolic links only"
    echo "  -p, --packages-only    Update packages only"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Default behavior (no options): Update both symlinks and packages"
}

# Main process
main() {
    local update_symlinks_flag=true
    local update_packages_flag=true
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -s|--symlinks-only)
                update_packages_flag=false
                shift
                ;;
            -p|--packages-only)
                update_symlinks_flag=false
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    log "Starting dotfiles update process..."
    
    # Pre-checks
    check_os
    check_dotfiles_directory
    
    # Update symbolic links
    if [ "$update_symlinks_flag" = true ]; then
        update_symlinks
    fi
    
    # Update packages
    if [ "$update_packages_flag" = true ]; then
        update_packages
    fi
    
    log "Update process completed successfully! ✨"
    
    # Offer to reload shell
    echo ""
    echo -e "${BLUE}💡 It's recommended to reload your shell to apply any changes.${NC}"
    echo -e "${BLUE}   Run: exec \$SHELL -l${NC}"
}

main "$@"