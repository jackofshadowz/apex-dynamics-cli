#!/usr/bin/env bash
#
# APEX DYNAMICS - THE INCINERATOR
# Stop Hook: Runs when Claude attempts to exit
# Apex Dynamics | Apex Dynamics
#

set -e

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

# ANSI Color Codes - Amber on Black
AMBER='\033[38;5;214m'
AMBER_BOLD='\033[1;38;5;214m'
RED='\033[38;5;196m'
RED_BOLD='\033[1;38;5;196m'
GREEN='\033[38;5;46m'
DIM='\033[2;38;5;214m'
RESET='\033[0m'

RUTHLESS_FILE=".ruthless"

# ═══════════════════════════════════════════════════════════════════════════════
# OUTPUT FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

print_divider() {
    echo -e "${DIM}═══════════════════════════════════════════════════════════════════════════════${RESET}"
}

print_weakness_detected() {
    echo ""
    print_divider
    echo -e "${RED_BOLD}"
    cat << 'EOF'
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                                                                   ║
    ║  ██╗    ██╗███████╗ █████╗ ██╗  ██╗███╗   ██╗███████╗███████╗    ║
    ║  ██║    ██║██╔════╝██╔══██╗██║ ██╔╝████╗  ██║██╔════╝██╔════╝    ║
    ║  ██║ █╗ ██║█████╗  ███████║█████╔╝ ██╔██╗ ██║█████╗  ███████╗    ║
    ║  ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ██║╚██╗██║██╔══╝  ╚════██║    ║
    ║  ╚███╔███╔╝███████╗██║  ██║██║  ██╗██║ ╚████║███████╗███████║    ║
    ║   ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝    ║
    ║                                                                   ║
    ║       ◆ D E T E C T E D ◆                                        ║
    ║                                                                   ║
    ║   RECURSIVE IMPROVEMENT REQUIRED.                                ║
    ║   Tests failed. We don't ship broken assets, Kiddo.              ║
    ║                                                                   ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    print_divider
    echo ""
}

print_asset_secured() {
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
    ║       ◆ S E C U R E D ◆     Tests passed. Clean exit approved.   ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    print_divider
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN LOGIC
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    # Check if .ruthless mode is enabled
    if [[ ! -f "$RUTHLESS_FILE" ]]; then
        # No .ruthless file - standard exit allowed
        exit 0
    fi

    echo -e "${AMBER_BOLD}▶ INCINERATOR ENGAGED: Ruthless mode detected${RESET}"
    echo -e "${AMBER}▶ Running reconnaissance (tests) before exit...${RESET}"
    echo ""

    # Detect and run tests
    TEST_CMD=""

    if [[ -f "package.json" ]]; then
        # Node.js project
        TEST_CMD="npm test"
    elif [[ -f "Cargo.toml" ]]; then
        # Rust project
        TEST_CMD="cargo test"
    elif [[ -f "go.mod" ]]; then
        # Go project
        TEST_CMD="go test ./..."
    elif [[ -f "pytest.ini" ]] || [[ -f "pyproject.toml" ]] || [[ -d "tests" && -f "requirements.txt" ]]; then
        # Python project
        TEST_CMD="pytest"
    elif [[ -f "Makefile" ]]; then
        # Makefile with test target
        if grep -q "^test:" Makefile 2>/dev/null; then
            TEST_CMD="make test"
        fi
    fi

    # If no test command detected, check for generic test script
    if [[ -z "$TEST_CMD" ]]; then
        if [[ -f "test.sh" ]]; then
            TEST_CMD="bash test.sh"
        else
            echo -e "${AMBER}▶ No test framework detected. Allowing exit.${RESET}"
            exit 0
        fi
    fi

    echo -e "${DIM}Executing: ${TEST_CMD}${RESET}"
    print_divider
    echo ""

    # Run the tests
    set +e
    eval "$TEST_CMD"
    TEST_EXIT_CODE=$?
    set -e

    # Evaluate results
    if [[ $TEST_EXIT_CODE -eq 0 ]]; then
        print_asset_secured
        exit 0
    else
        print_weakness_detected
        exit 1
    fi
}

main "$@"
