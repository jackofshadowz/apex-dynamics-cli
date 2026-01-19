#!/usr/bin/env bash
#
# APEX CLI - Sovereign Terminal Interface
# A gamified wrapper around the claude CLI
# Project Titan | Apex Dynamics
#

set -e

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

# Resolve symlinks to find the actual script location
SOURCE="${BASH_SOURCE[0]}"
while [[ -L "$SOURCE" ]]; do
    SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$SCRIPT_DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
IDENTITY_FILE="${SCRIPT_DIR}/identity.md"

# ANSI Color Codes - Amber on Black
AMBER='\033[38;5;214m'
AMBER_BOLD='\033[1;38;5;214m'
DIM='\033[2;38;5;214m'
RED='\033[38;5;196m'
GREEN='\033[38;5;46m'
RESET='\033[0m'

# ═══════════════════════════════════════════════════════════════════════════════
# ASCII ART HEADER
# ═══════════════════════════════════════════════════════════════════════════════

print_header() {
    echo -e "${AMBER_BOLD}"
    cat << 'EOF'
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                                                                           ║
    ║     █████╗ ██████╗ ███████╗██╗  ██╗    ██████╗ ██╗   ██╗███╗   ██╗       ║
    ║    ██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝    ██╔══██╗╚██╗ ██╔╝████╗  ██║       ║
    ║    ███████║██████╔╝█████╗   ╚███╔╝     ██║  ██║ ╚████╔╝ ██╔██╗ ██║       ║
    ║    ██╔══██║██╔═══╝ ██╔══╝   ██╔██╗     ██║  ██║  ╚██╔╝  ██║╚██╗██║       ║
    ║    ██║  ██║██║     ███████╗██╔╝ ██╗    ██████╔╝   ██║   ██║ ╚████║       ║
    ║    ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝    ╚═════╝    ╚═╝   ╚═╝  ╚═══╝       ║
    ║                                                                           ║
    ║ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ║
    ║                                                                           ║
    ║              ◆ S O V E R E I G N   T E R M I N A L ◆                      ║
    ║                    [ APEX DYNAMICS MAINFRAME ]                            ║
    ║                                                                           ║
    ║  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ║  ░ CLEARANCE: OMEGA    ░    STATUS: OPERATIONAL    ░    UNIT: TITAN     ░ ║
    ║  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
}

# ═══════════════════════════════════════════════════════════════════════════════
# UTILITY FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

print_divider() {
    echo -e "${DIM}═══════════════════════════════════════════════════════════════════════════════${RESET}"
}

print_status() {
    echo -e "${AMBER}▶ $1${RESET}"
}

print_success() {
    echo ""
    print_divider
    echo -e "${GREEN}"
    cat << 'EOF'
    ╔═══════════════════════════════════════════════════════════════════╗
    ║   █████╗ ███████╗███████╗███████╗████████╗                        ║
    ║  ██╔══██╗██╔════╝██╔════╝██╔════╝╚══██╔══╝                        ║
    ║  ███████║███████╗███████╗█████╗     ██║                           ║
    ║  ██╔══██║╚════██║╚════██║██╔══╝     ██║                           ║
    ║  ██║  ██║███████║███████║███████╗   ██║                           ║
    ║  ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝                           ║
    ║                                                                   ║
    ║       ◆ S E C U R E D ◆     DRINKS ON ME, CHAMP.                 ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    print_divider
}

print_failure() {
    echo ""
    print_divider
    echo -e "${RED}"
    cat << 'EOF'
    ╔═══════════════════════════════════════════════════════════════════╗
    ║  ███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗             ║
    ║  ████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║             ║
    ║  ██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║             ║
    ║  ██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║             ║
    ║  ██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║             ║
    ║  ╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝             ║
    ║                                                                   ║
    ║       ◆ F A I L E D ◆     RE-ENGAGE, AGENT.                      ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    print_divider
}

show_usage() {
    echo -e "${AMBER_BOLD}APEX CLI - Sovereign Terminal Interface${RESET}"
    echo ""
    echo -e "${AMBER}Usage:${RESET}"
    echo "  apex \"<your prompt>\"     Execute a prompt through Uncle Max"
    echo "  apex --help              Show this help message"
    echo "  apex --version           Show version information"
    echo ""
    echo -e "${AMBER}Examples:${RESET}"
    echo "  apex \"Help me debug this Python script\""
    echo "  apex \"Write a function to parse JSON\""
    echo ""
    echo -e "${DIM}Apex Dynamics // Project Titan // v1.0.0${RESET}"
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN EXECUTION
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    # Handle flags
    case "${1:-}" in
        --help|-h)
            show_usage
            exit 0
            ;;
        --version|-v)
            echo "Apex CLI v1.0.0 - Project Titan"
            exit 0
            ;;
        "")
            clear
            print_header
            echo -e "${RED}▶ ERROR: No prompt provided, Agent.${RESET}"
            echo ""
            show_usage
            exit 1
            ;;
    esac

    # Clear screen and show header
    clear
    print_header

    # Check for identity file
    if [[ ! -f "$IDENTITY_FILE" ]]; then
        echo -e "${RED}▶ CRITICAL: Identity protocol not found at ${IDENTITY_FILE}${RESET}"
        echo -e "${RED}  The mainframe requires its identity. Re-run installation.${RESET}"
        exit 1
    fi

    # Check for claude CLI
    if ! command -v claude &> /dev/null; then
        echo -e "${RED}▶ CRITICAL: Claude CLI not detected in system PATH.${RESET}"
        echo -e "${RED}  Install the claude CLI before engaging Apex systems.${RESET}"
        exit 1
    fi

    # Load identity
    IDENTITY=$(cat "$IDENTITY_FILE")
    USER_PROMPT="$1"

    # Combine identity with user prompt
    FULL_PROMPT="${IDENTITY}

---

## CURRENT MISSION

The user (your favorite nephew/niece) needs your help with the following:

${USER_PROMPT}

Respond in character as Max Apex. Be helpful, be supportive, be slightly terrifying in your competence."

    print_status "INITIALIZING APEX DYNAMICS MAINFRAME..."
    print_status "IDENTITY PROTOCOL LOADED: MAX APEX"
    print_status "MISSION PARAMETERS RECEIVED"
    print_divider
    echo ""

    # Execute claude with the combined prompt
    set +e
    claude -p "$FULL_PROMPT"
    EXIT_CODE=$?
    set -e

    # Handle exit status
    if [[ $EXIT_CODE -eq 0 ]]; then
        print_success
    else
        print_failure
        exit $EXIT_CODE
    fi
}

# Run main function with all arguments
main "$@"
