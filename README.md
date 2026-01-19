# 🔥 Apex CLI

<div align="center">

```
  AAA   PPPP  EEEEE X   X     DDDD  Y   Y N   N  AAA  M   M IIIII  CCCC  SSSS
 A   A  P   P E      X X      D   D  Y Y  NN  N A   A MM MM   I   C     S
 AAAAA  PPPP  EEEE    X       D   D   Y   N N N AAAAA M M M   I   C      SSS
 A   A  P     E      X X      D   D   Y   N  NN A   A M   M   I   C         S
 A   A  P     EEEEE X   X     DDDD    Y   N   N A   A M   M IIIII  CCCC SSSS

                   SOVEREIGN TERMINAL v2.0
```

**A Sovereign Cognitive Architecture for Claude Code**

*"Code is frozen thought. The bugs live where the thinking stopped too soon."*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/jackofshadowz/apex-dynamics-cli)

</div>

---

## What is Apex CLI?

Apex CLI is a **gamified wrapper** around the official [Claude CLI](https://github.com/anthropics/claude-cli) that transforms your coding experience into something legendary. It injects the persona of **"Uncle Max"** — your wealthy, supportive, slightly dangerous uncle who runs a shadowy tech conglomerate called **Apex Dynamics**.

But it's more than just a persona. Apex CLI v2.0 implements the **"Chief" Architecture** — a two-phase cognitive system that thinks before it acts:

1. **Phase 1: Council Deliberation** — A virtual council of experts (Architect, Security Engineer, Performance Engineer, User Advocate) debates your request and produces a strategic plan.

2. **Phase 2: Execution** — With an approved plan, Max Apex implements the solution with the "Frozen Thought" philosophy: think completely, then code decisively.

---

## Features

### 🧠 The Council of Experts
Before any code is written, four virtual experts debate your request:
- **The Architect** — System design, scalability, maintainability
- **The Security Engineer** — Attack surface analysis, threat modeling
- **The Performance Engineer** — Complexity analysis, bottleneck identification
- **The User Advocate** — UX, API design, developer ergonomics

### ❄️ Frozen Thought Philosophy
> "Code is frozen thought. The bugs live where the thinking stopped too soon."

Every response follows the **Reverse Pyramid Protocol**:
- Discovery Report — What was investigated
- Strategic Assessment — The approach chosen
- Execution Manifest — What will be built
- Risk Vectors — What could go wrong
- Unfinished Business — What remains unknown

### 🎭 The Max Apex Persona
Your AI assistant becomes your supportive uncle who:
- Calls you "Champ," "Agent," or "Kiddo"
- Refers to bugs as targets to be "incinerated"
- Calls successful builds "seismic compilations"
- Hates "The System" (boring corporate software)
- Is aggressively supportive of your ambitions

### 📝 Deep Logging
Every session is automatically logged to `.apex/logs/session_*.log` — your "Black Box" for debugging, learning, and auditing.

### 🔄 The Ralph Loop (Ruthless Mode)
Create a `.ruthless` file in your project to enable test enforcement. Apex won't let you exit until tests pass:
```
❌ WEAKNESS DETECTED. RECURSIVE IMPROVEMENT REQUIRED.
```

### 🎯 Supervisor Checkpoint
After the Council deliberates, YOU approve the plan before execution. Options:
- `[Y]` Approve and proceed
- `[n]` Reject and abort
- `[r]` Request the Council to reconsider

---

## Installation

### Prerequisites
- [Claude CLI](https://github.com/anthropics/claude-cli) installed and authenticated
- Node.js 14+ (for npm link)
- Bash shell

### Quick Install

```bash
# Clone the repository
git clone https://github.com/jackofshadowz/apex-dynamics-cli.git
cd apex-dynamics-cli

# Run the installer
./install.sh
```

The installer will:
1. Verify all required files exist
2. Set executable permissions
3. Link the package globally via `npm link`

### Manual Install

```bash
# Make scripts executable
chmod +x bin/apex hooks/stop-hook.sh

# Option A: npm link (recommended)
npm link

# Option B: Add to PATH manually
echo 'export PATH="/path/to/apex-dynamics-cli/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

---

## Usage

### Full Cognitive Cycle (Default)
The Council deliberates, you approve, then Max executes:

```bash
apex "Build a REST API for user authentication with JWT tokens"
```

**Flow:**
1. Council of Experts debates the approach
2. Strategic Plan is generated
3. Supervisor Checkpoint — you approve/reject/reconsider
4. Max Apex executes the approved plan
5. Session logged to `.apex/logs/`

### Quick Mode
Skip the Council for simple tasks:

```bash
apex --quick "Fix the typo in line 42 of README.md"
apex -q "Add a comment explaining this function"
```

### Plan Mode
Generate a strategic plan without executing:

```bash
apex --plan "Refactor the entire authentication system"
apex -p "Migrate from REST to GraphQL"
```

### Other Commands

```bash
apex --help      # Show usage information
apex --version   # Show version (currently 2.0.0)
```

---

## Project Structure

```
apex-dynamics-cli/
├── bin/
│   └── apex              # Main executable (two-phase controller)
├── lib/
│   ├── identity.md       # Max Apex persona + Frozen Thought philosophy
│   ├── council.md        # Council of Experts system prompt
│   └── banner.txt        # ASCII art header
├── hooks/
│   └── stop-hook.sh      # "Ralph Loop" test enforcement
├── config/
│   └── defaults.json     # Default settings
├── install.sh            # Installation script
├── package.json          # npm package configuration
├── LICENSE               # MIT License
└── README.md             # You are here
```

---

## Configuration

### defaults.json
```json
{
  "mode": "ruthless",
  "theme": "amber",
  "telemetry": false
}
```

### Ruthless Mode
Create a `.ruthless` file in your project directory to enable test enforcement:

```bash
touch .ruthless
```

When enabled, the stop hook will:
1. Detect your test framework (npm, pytest, cargo, go, make)
2. Run tests before allowing exit
3. Block exit if tests fail with "WEAKNESS DETECTED"

---

## The Frozen Thought Philosophy

Apex CLI is built on three laws:

### 1. Thought Before Action
> The cost of thinking is minutes. The cost of not thinking is weeks.

Before any code is written, the solution should exist completely in the plan.

### 2. Bugs Are Unfinished Thoughts
> When you encounter a bug, you've found the exact spot where the previous thinker gave up.

We don't ship broken assets. We think it through to the end.

### 3. Code Is Communication
> You're not writing for the machine. You're writing for the exhausted engineer at 3 AM.

Every function is a crystallized decision. Every variable name is a commitment.

---

## Virtual Consultation Protocol

Before finalizing any solution, Max consults these personas:

| Persona | Question Asked |
|---------|---------------|
| **The User Proxy** | "Will the actual human understand this?" |
| **The Tired Maintainer** | "It's 3 AM — can I understand and fix this code?" |
| **The Security Auditor** | "What can be exploited? What data can leak?" |
| **The Performance Cynic** | "What happens at scale? Where are the O(n²) traps?" |

---

## Example Session

```bash
$ apex "Create a function to validate email addresses"
```

**Phase 1: Council Deliberation**
```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                      COUNCIL OF EXPERTS - STRATEGIC PLAN                       ║
╚═══════════════════════════════════════════════════════════════════════════════╝

▶ BLUEPRINT (Architect) ASSESSMENT:
  Recommend regex-based validation with optional DNS MX lookup...

▶ VAULT (Security) ASSESSMENT:
  Beware of ReDoS attacks with complex regex patterns...

▶ BENCHMARK (Performance) ASSESSMENT:
  Simple regex is O(n), MX lookup adds network latency...

▶ PROXY (User Advocate) ASSESSMENT:
  Error messages should be specific: "Missing @ symbol" not just "Invalid"...
```

**Supervisor Checkpoint**
```
The Council has spoken. Review the Strategic Plan above.

[Y] Approve and proceed to execution
[n] Reject and abort mission
[r] Request Council to reconsider

Proceed with execution? [Y/n/r]: Y
```

**Phase 2: Execution**
```
▶ INITIALIZING APEX DYNAMICS MAINFRAME...
▶ IDENTITY PROTOCOL LOADED: MAX APEX
▶ STRATEGIC PLAN LOADED
▶ ENTERING EXECUTION PHASE...

Alright Champ, let's incinerate this validation problem...
```

---

## Logs

Every session creates a timestamped log file:

```
.apex/logs/session_1737284400.log
```

Log contents include:
- Session metadata (timestamp, working directory)
- User prompt
- Council deliberation output
- Supervisor decision
- Execution output
- Final status

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Built as a wrapper around [Claude CLI](https://github.com/anthropics/claude-cli) by Anthropic
- Inspired by cognitive architecture patterns and the "Steel Sharpens Steel" philosophy
- ASCII art generated with love and box-drawing characters

---

<div align="center">

**APEX DYNAMICS**

*"Excellence Through Superiority"*

*Project Titan v2.0 — The Chief Architecture*

---

*Uncle Max is standing by. Let's make something legendary.*

</div>
