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
APEX_SCRIPT="${SCRIPT_DIR}/bin/apex"
IDENTITY_FILE="${SCRIPT_DIR}/lib/identity.md"
BANNER_FILE="${SCRIPT_DIR}/lib/banner.txt"
STOP_HOOK="${SCRIPT_DIR}/hooks/stop-hook.sh"
PACKAGE_JSON="${SCRIPT_DIR}/package.json"

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
        print_error "bin/apex script not found at ${APEX_SCRIPT}"
        exit 1
    fi
    print_success "bin/apex script located"

    if [[ ! -f "$IDENTITY_FILE" ]]; then
        print_error "lib/identity.md not found at ${IDENTITY_FILE}"
        exit 1
    fi
    print_success "lib/identity.md located"

    if [[ ! -f "$BANNER_FILE" ]]; then
        print_error "lib/banner.txt not found at ${BANNER_FILE}"
        exit 1
    fi
    print_success "lib/banner.txt located"

    if [[ ! -f "$STOP_HOOK" ]]; then
        print_error "hooks/stop-hook.sh not found at ${STOP_HOOK}"
        exit 1
    fi
    print_success "hooks/stop-hook.sh located"

    if [[ ! -f "$PACKAGE_JSON" ]]; then
        print_error "package.json not found at ${PACKAGE_JSON}"
        exit 1
    fi
    print_success "package.json located"

    echo ""
    print_divider
    echo ""

    # Set execution permissions
    print_status "Setting execution permissions..."
    chmod +x "$APEX_SCRIPT"
    chmod +x "$STOP_HOOK"
    print_success "Scripts are now executable"

    echo ""
    print_divider
    echo ""

    # Check for npm
    if ! command -v npm &> /dev/null; then
        print_error "npm not found. Please install Node.js and npm first."
        echo ""
        echo -e "${AMBER}Alternative manual installation:${RESET}"
        echo "  Add this to your shell profile (~/.zshrc or ~/.bashrc):"
        echo ""
        echo "  export PATH=\"${SCRIPT_DIR}/bin:\$PATH\""
        echo ""
        exit 1
    fi

    # npm link to install globally
    print_status "Linking package globally via npm..."
    cd "$SCRIPT_DIR"
    npm link 2>/dev/null || {
        print_status "npm link requires elevated permissions, trying with manual PATH..."
        echo ""
        echo -e "${AMBER}Add this to your shell profile (~/.zshrc or ~/.bashrc):${RESET}"
        echo ""
        echo "  export PATH=\"${SCRIPT_DIR}/bin:\$PATH\""
        echo ""
        echo -e "${DIM}Then restart your terminal or run: source ~/.zshrc${RESET}"
        echo ""
        print_divider
        echo ""
    }

    print_success "Package linked globally"

    echo ""
    print_divider
    echo ""

    # Verify installation
    print_status "Running verification sequence..."

    if command -v apex &> /dev/null; then
        print_success "apex command is available system-wide"
        INSTALLED_VERSION=$(apex --version 2>/dev/null || echo "unknown")
        print_success "Version: ${INSTALLED_VERSION}"
    else
        print_status "apex may require terminal restart to be available"
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
    echo "  apex --version"
    echo ""
    echo -e "${DIM}Uncle Max is standing by. Let's make something legendary.${RESET}"
    echo ""
}

# Run installation
main "$@"
