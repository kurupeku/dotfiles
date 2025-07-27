#!/bin/bash

set -e

# =============================================================================
# FUNCTIONS
# =============================================================================

# Log output function
log() {
    echo "🔧 $1"
}

# Error handling function
die() {
    echo "❌ Error: $1" >&2
    exit 1
}

# Install mise using curl
install_mise() {
    if ! command -v mise >/dev/null 2>&1; then
        log "Installing mise..."
        
        # Download and install mise using the official install script
        if command -v curl >/dev/null 2>&1; then
            curl https://mise.run | sh
        else
            die "curl is required to install mise"
        fi
        
        # Add mise to PATH for current session only (until shell restart)
        export PATH="$HOME/.local/bin:$PATH"
        
        # Verify installation
        if ! command -v mise >/dev/null 2>&1; then
            die "Failed to install mise"
        fi
        
        log "mise installed successfully"
    else
        log "mise is already installed"
    fi
}

# Install tools from config.toml
install_tools() {
    log "Installing tools from config.toml..."
    
    # Install all tools defined in the config file
    if mise install; then
        log "All tools installed successfully"
    else
        log "Some tools failed to install, continuing..."
    fi
}

# =============================================================================
# MAIN PROCESS
# =============================================================================

main() {
    log "Starting mise setup..."
    
    # Install mise
    install_mise
    
    # Install tools from config.toml (symlinked from dotfiles)
    install_tools
    
    # Activate mise for current session (auto-detect shell)
    eval "$(mise activate)"
    
    log "mise setup completed successfully ✨"
    log "Tools are managed via ~/.config/mise/config.toml"
}

main