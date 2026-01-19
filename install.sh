#!/usr/bin/env bash
#
# APEX CLI - Installation Script
# Project Titan | Apex Dynamics
#

set -e

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APEX_SCRIPT="${SCRIPT_DIR}/apex"
IDENTITY_FILE="${SCRIPT_DIR}/identity.md"
INSTALL_DIR="${HOME}/.local/bin"
SYMLINK_PATH="${INSTALL_DIR}/apex"

# ANSI Color Codes
AMBER='\033[38;5;214m'
AMBER_BOLD='\033[1;38;5;214m'
GREEN='\033[38;5;46m'
RED='\033[38;5;196m'
DIM='\033[2;38;5;214m'
RESET='\033[0m'

# ═══════════════════════════════════════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

print_header() {
    echo -e "${AMBER_BOLD}"
    cat << 'EOF'
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                                                                   ║
    ║       █████╗ ██████╗ ███████╗██╗  ██╗                            ║
    ║      ██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝                            ║
    ║      ███████║██████╔╝█████╗   ╚███╔╝                             ║
    ║      ██╔══██║██╔═══╝ ██╔══╝   ██╔██╗                             ║
    ║      ██║  ██║██║     ███████╗██╔╝ ██╗                            ║
    ║      ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝                            ║
    ║                                                                   ║
    ║            ◆ I N S T A L L A T I O N   S E Q U E N C E ◆         ║
    ║                      [ PROJECT TITAN ]                            ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
}

print_status() {
    echo -e "${AMBER}▶ $1${RESET}"
}

print_success() {
    echo -e "${GREEN}✓ $1${RESET}"
}

print_error() {
    echo -e "${RED}✗ $1${RESET}"
}

print_divider() {
    echo -e "${DIM}═══════════════════════════════════════════════════════════════════════${RESET}"
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN INSTALLATION
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    clear
    print_header
    print_divider
    echo ""

    # Check for required files
    print_status "Verifying installation assets..."

    if [[ ! -f "$APEX_SCRIPT" ]]; then
        print_error "apex script not found at ${APEX_SCRIPT}"
        exit 1
    fi
    print_success "apex script located"

    if [[ ! -f "$IDENTITY_FILE" ]]; then
        print_error "identity.md not found at ${IDENTITY_FILE}"
        exit 1
    fi
    print_success "identity.md located"

    echo ""
    print_divider
    echo ""

    # Make apex executable
    print_status "Setting execution permissions..."
    chmod +x "$APEX_SCRIPT"
    print_success "apex script is now executable"

    echo ""
    print_divider
    echo ""

    # Create symlink
    print_status "Creating system symlink..."

    if [[ -L "$SYMLINK_PATH" ]]; then
        print_status "Existing symlink detected. Removing..."
        rm "$SYMLINK_PATH"
    elif [[ -f "$SYMLINK_PATH" ]]; then
        print_error "A file (not symlink) exists at ${SYMLINK_PATH}"
        print_error "Please remove it manually and re-run installation."
        exit 1
    fi

    # Check if install directory exists
    if [[ ! -d "$INSTALL_DIR" ]]; then
        print_status "Creating ${INSTALL_DIR}..."
        mkdir -p "$INSTALL_DIR"
    fi

    ln -s "$APEX_SCRIPT" "$SYMLINK_PATH"
    print_success "Symlink created: ${SYMLINK_PATH} -> ${APEX_SCRIPT}"

    echo ""
    print_divider
    echo ""

    # Verify installation
    print_status "Running verification sequence..."

    if command -v apex &> /dev/null; then
        print_success "apex command is available system-wide"
    else
        print_status "apex installed to ${INSTALL_DIR}"
        echo ""
        echo -e "${AMBER}Add this to your shell profile (~/.zshrc or ~/.bashrc):${RESET}"
        echo ""
        echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo ""
        echo -e "${DIM}Then restart your terminal or run: source ~/.zshrc${RESET}"
    fi

    echo ""
    print_divider
    echo ""

    # Installation complete
    echo -e "${GREEN}"
    cat << 'EOF'
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                                                                   ║
    ║        ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗       ║
    ║       ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝       ║
    ║       ██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗         ║
    ║       ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝         ║
    ║       ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗       ║
    ║        ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝       ║
    ║                                                                   ║
    ║       ◆ APEX DYNAMICS MAINFRAME ONLINE ◆                         ║
    ║                                                                   ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"

    echo -e "${AMBER_BOLD}Welcome to the family, Agent.${RESET}"
    echo ""
    echo -e "${AMBER}Usage:${RESET}"
    echo "  apex \"Help me write a Python function\""
    echo "  apex \"Debug this code for me\""
    echo "  apex --help"
    echo ""
    echo -e "${DIM}Uncle Max is standing by. Let's make something legendary.${RESET}"
    echo ""
}

# Run installation
main "$@"
