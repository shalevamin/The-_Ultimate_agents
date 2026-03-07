#!/bin/bash
# ╔══════════════════════════════════════════════════════════════╗
# ║         TUA AGENT — THE ULTIMATE AGENT                      ║
# ║         One-Line Installer & Onboarding                     ║
# ║                                                              ║
# ║  curl -fsSL https://raw.githubusercontent.com/               ║
# ║    shalevamin/The-_Ultimate_agents/main/setup.sh | bash      ║
# ╚══════════════════════════════════════════════════════════════╝

set -e

# ── Helpers ──────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

TTY="/dev/tty"  # Always read from tty (works with piped curl)

print_line()  { echo -e "${DIM}────────────────────────────────────────────────────────${NC}"; }
print_ok()    { echo -e "  ${GREEN}✓${NC} $1"; }
print_warn()  { echo -e "  ${YELLOW}!${NC} $1"; }
print_fail()  { echo -e "  ${RED}✗${NC} $1"; }
print_phase() { echo ""; print_line; echo -e "  ${CYAN}${BOLD}$1${NC}"; print_line; echo ""; }

# ═══════════════════════════════════════════════════════════════
#  PHASE 1 — DANGER WARNING & CONSENT
# ═══════════════════════════════════════════════════════════════
clear 2>/dev/null || true
echo ""
echo -e "${RED}${BOLD}"
echo "  ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗██████╗ "
echo "  ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝██╔══██╗"
echo "  ██║  ██║███████║██╔██╗ ██║██║  ███╗█████╗  ██████╔╝"
echo "  ██║  ██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██╔══██╗"
echo "  ██████╔╝██║  ██║██║ ╚████║╚██████╔╝███████╗██║  ██║"
echo "  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo ""
echo -e "${RED}${BOLD}  ⚠️  DANGEROUS TOOL — READ CAREFULLY ⚠️${NC}"
echo ""
echo -e "  ${YELLOW}This software gives an AI agent FULL CONTROL of your computer:${NC}"
echo ""
echo -e "  ${RED}•${NC} 🖱️  Mouse & Keyboard — can click anywhere, type anything"
echo -e "  ${RED}•${NC} 📸 Screen Recording — sees everything on your screen"
echo -e "  ${RED}•${NC} 🌐 Browser Control — can browse the web with YOUR accounts"
echo -e "  ${RED}•${NC} 📁 File System — can read, write, delete ANY file"
echo -e "  ${RED}•${NC} 🖥️  App Control — can open, close, and control ANY application"
echo -e "  ${RED}•${NC} ⌨️  Terminal — can execute ANY command on your computer"
echo ""
echo -e "  ${RED}${BOLD}THIS TOOL IS INTENDED FOR DEVELOPERS & POWER USERS ONLY.${NC}"
echo -e "  ${RED}${BOLD}USE AT YOUR OWN RISK. THE AUTHORS ARE NOT RESPONSIBLE${NC}"
echo -e "  ${RED}${BOLD}FOR ANY DAMAGE CAUSED BY THIS SOFTWARE.${NC}"
echo ""
print_line
echo ""
echo -e "  ${YELLOW}${BOLD}To proceed, type exactly: ${CYAN}I UNDERSTAND${NC}"
echo ""
echo -n "  → "
read -r CONSENT < "$TTY"

if [ "$CONSENT" != "I UNDERSTAND" ]; then
    echo ""
    echo -e "  ${RED}Installation cancelled.${NC} You did not type 'I UNDERSTAND'."
    echo ""
    exit 1
fi

echo ""
echo -e "  ${GREEN}${BOLD}✓ Consent acknowledged. Proceeding with installation...${NC}"
sleep 1

# ═══════════════════════════════════════════════════════════════
#  PHASE 2 — SYSTEM SCAN (check what's already installed)
# ═══════════════════════════════════════════════════════════════
print_phase "PHASE 2/7 — Scanning Your System..."

TOTAL_INSTALLED=0
TOTAL_MISSING=0

check_tool() {
    local name="$1"
    local cmd="$2"
    local var_name="$3"
    if command -v "$cmd" &>/dev/null; then
        local ver
        ver=$($cmd --version 2>&1 | head -1) || ver="installed"
        eval "$var_name=true"
        print_ok "${BOLD}$name${NC} — ${DIM}$ver${NC}"
        TOTAL_INSTALLED=$((TOTAL_INSTALLED + 1))
    else
        eval "$var_name=false"
        print_fail "${BOLD}$name${NC} — not found"
        TOTAL_MISSING=$((TOTAL_MISSING + 1))
    fi
}

echo -e "  ${CYAN}Checking pre-installed tools...${NC}"
echo ""

check_tool "Homebrew"    "brew"    "HAS_HOMEBREW"
check_tool "Node.js"     "node"    "HAS_NODE"
check_tool "npm"         "npm"     "HAS_NPM"
check_tool "Python3"     "python3" "HAS_PYTHON3"
check_tool "pip3"        "pip3"    "HAS_PIP3"
check_tool "uv"          "uv"      "HAS_UV"
check_tool "Git"         "git"     "HAS_GIT"
check_tool "Codex CLI"   "codex"   "HAS_CODEX"

# Check Playwright
if python3 -c "import playwright" 2>/dev/null; then
    HAS_PLAYWRIGHT="true"
    print_ok "${BOLD}Playwright${NC} — installed"
    TOTAL_INSTALLED=$((TOTAL_INSTALLED + 1))
else
    HAS_PLAYWRIGHT="false"
    print_fail "${BOLD}Playwright${NC} — not found"
    TOTAL_MISSING=$((TOTAL_MISSING + 1))
fi

# Check browser-use
if python3 -c "import browser_use" 2>/dev/null; then
    HAS_BROWSER_USE="true"
    print_ok "${BOLD}browser-use${NC} — installed"
    TOTAL_INSTALLED=$((TOTAL_INSTALLED + 1))
else
    HAS_BROWSER_USE="false"
    print_fail "${BOLD}browser-use${NC} — not found"
    TOTAL_MISSING=$((TOTAL_MISSING + 1))
fi

echo ""
echo -e "  ${GREEN}$TOTAL_INSTALLED installed${NC} · ${YELLOW}$TOTAL_MISSING to install${NC}"
sleep 1

# ═══════════════════════════════════════════════════════════════
#  PHASE 3 — macOS PERMISSION DIALOGS
# ═══════════════════════════════════════════════════════════════
print_phase "PHASE 3/7 — Requesting macOS Permissions..."

# 3a. Accessibility
echo -e "  ${YELLOW}[1/3] Accessibility Permission${NC}"
osascript << 'APPLESCRIPT' 2>/dev/null || true
display dialog "🔐 PERMISSION REQUIRED: Accessibility

Tua Agent needs Accessibility permission to:
• Control mouse movements and clicks
• Simulate keyboard input
• Automate GUI interactions

Click 'Open Settings' to grant access:
1. Click the '+' button
2. Add your Terminal app
3. Toggle it ON" buttons {"Skip", "Open Settings"} default button "Open Settings" with title "TUA Agent — Accessibility" with icon caution
if button returned of result is "Open Settings" then
    tell application "System Settings" to activate
    open location "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
end if
APPLESCRIPT
print_ok "Accessibility dialog shown"

# 3b. Screen Recording
echo -e "  ${YELLOW}[2/3] Screen Recording Permission${NC}"
osascript << 'APPLESCRIPT' 2>/dev/null || true
display dialog "📸 PERMISSION REQUIRED: Screen Recording

Tua Agent needs Screen Recording to:
• Take screenshots for AI analysis
• Monitor application state
• Understand visual context on screen

Click 'Open Settings' to grant access." buttons {"Skip", "Open Settings"} default button "Open Settings" with title "TUA Agent — Screen Recording" with icon caution
if button returned of result is "Open Settings" then
    open location "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture"
end if
APPLESCRIPT
print_ok "Screen Recording dialog shown"

# 3c. Admin / sudo
echo -e "  ${YELLOW}[3/3] Admin Privileges${NC}"
osascript << 'APPLESCRIPT' 2>/dev/null || true
display dialog "🔑 ADMIN ACCESS REQUIRED

Some installations require admin privileges:
• Installing Homebrew packages
• Installing global npm packages
• Installing Python packages

You will be prompted for your Mac password." buttons {"Skip", "Continue"} default button "Continue" with title "TUA Agent — Admin Access" with icon caution
APPLESCRIPT

echo ""
echo -e "  ${BOLD}Enter your Mac password for admin access (or press Enter to skip):${NC}"
sudo -v 2>/dev/null && print_ok "Admin access granted" || print_warn "Continuing without admin (some features may be limited)"
sleep 1

# ═══════════════════════════════════════════════════════════════
#  PHASE 4 — API KEY & MODEL SELECTION
# ═══════════════════════════════════════════════════════════════
print_phase "PHASE 4/7 — API Key & Model Configuration"

echo -e "  ${CYAN}${BOLD}🔑 Enter your OpenAI API key${NC}"
echo -e "  ${DIM}Get one at: https://platform.openai.com/api-keys${NC}"
echo -e "  ${DIM}(This is the ONLY key you need)${NC}"
echo ""
echo -n "  API Key → "
read -rs API_KEY < "$TTY"
echo ""

if [ -z "$API_KEY" ]; then
    print_warn "No API key entered — you can add it later in .env"
else
    print_ok "API key received"
fi

echo ""
echo -e "  ${CYAN}${BOLD}🤖 Choose your default AI model:${NC}"
echo ""
echo -e "  ${BOLD}1)${NC} gpt-4.5         ${DIM}— Latest flagship (recommended)${NC}"
echo -e "  ${BOLD}2)${NC} gpt-4o          ${DIM}— Standard fast model${NC}"
echo -e "  ${BOLD}3)${NC} gpt-4o-mini     ${DIM}— Faster, cheaper${NC}"
echo -e "  ${BOLD}4)${NC} o3              ${DIM}— Advanced reasoning${NC}"
echo -e "  ${BOLD}5)${NC} o3-mini         ${DIM}— Fast reasoning${NC}"
echo ""
echo -n "  Choice [1-5, default=1] → "
read -r MODEL_CHOICE < "$TTY"

case "$MODEL_CHOICE" in
    2) SELECTED_MODEL="gpt-4o" ;;
    3) SELECTED_MODEL="gpt-4o-mini" ;;
    4) SELECTED_MODEL="o3" ;;
    5) SELECTED_MODEL="o3-mini" ;;
    *) SELECTED_MODEL="gpt-4.5" ;;
esac

print_ok "Selected model: ${BOLD}$SELECTED_MODEL${NC}"
sleep 1

# ═══════════════════════════════════════════════════════════════
#  PHASE 5 — INSTALLATION (only missing tools)
# ═══════════════════════════════════════════════════════════════
print_phase "PHASE 5/7 — Installing Dependencies..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Determine project root (if run via curl, clone first)
if [ ! -f "$SCRIPT_DIR/CLAUDE.md" ]; then
    echo -e "  ${CYAN}Cloning TUA Agent from GitHub...${NC}"
    CLONE_DIR="$HOME/tua-agent"
    if [ -d "$CLONE_DIR" ]; then
        print_warn "Directory $CLONE_DIR already exists — updating..."
        cd "$CLONE_DIR" && git pull 2>/dev/null || true
    else
        git clone https://github.com/shalevamin/The-_Ultimate_agents.git "$CLONE_DIR"
        cd "$CLONE_DIR"
    fi
    SCRIPT_DIR="$CLONE_DIR"
    print_ok "Project cloned to $CLONE_DIR"
fi

TUA_DIR="$SCRIPT_DIR"

# 5a. Homebrew
if [ "$HAS_HOMEBREW" = "false" ]; then
    echo -e "  ${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < "$TTY" && print_ok "Homebrew installed" || print_warn "Homebrew installation failed — skipping"
else
    print_ok "Homebrew — already installed, skipping"
fi

# 5b. Node.js
if [ "$HAS_NODE" = "false" ]; then
    echo -e "  ${YELLOW}Installing Node.js...${NC}"
    if command -v brew &>/dev/null; then
        brew install node && print_ok "Node.js installed" || print_warn "Node.js installation failed"
    else
        print_warn "Install Node.js manually: https://nodejs.org"
    fi
else
    print_ok "Node.js — already installed, skipping"
fi

# 5c. Python3
if [ "$HAS_PYTHON3" = "false" ]; then
    echo -e "  ${YELLOW}Installing Python3...${NC}"
    if command -v brew &>/dev/null; then
        brew install python3 && print_ok "Python3 installed" || print_warn "Python3 installation failed"
    else
        print_warn "Install Python3 manually: https://python.org"
    fi
else
    print_ok "Python3 — already installed, skipping"
fi

# 5d. browser-use + Playwright
if [ "$HAS_BROWSER_USE" = "false" ]; then
    echo -e "  ${YELLOW}Installing browser-use...${NC}"
    pip3 install browser-use 2>/dev/null && print_ok "browser-use installed" || {
        pip3 install --user browser-use 2>/dev/null && print_ok "browser-use installed (user)" || print_warn "browser-use: install manually with 'pip3 install browser-use'"
    }
fi

if [ "$HAS_PLAYWRIGHT" = "false" ]; then
    echo -e "  ${YELLOW}Installing Playwright + Chromium...${NC}"
    pip3 install playwright 2>/dev/null || pip3 install --user playwright 2>/dev/null || true
    python3 -m playwright install chromium 2>/dev/null && print_ok "Playwright + Chromium installed" || print_warn "Run: python3 -m playwright install chromium"
else
    print_ok "Playwright — already installed, skipping"
fi

# 5e. Codex CLI
if [ "$HAS_CODEX" = "false" ]; then
    echo -e "  ${YELLOW}Installing OpenAI Codex CLI...${NC}"
    npm install -g @openai/codex 2>/dev/null && print_ok "Codex CLI installed" || print_warn "Run: npm install -g @openai/codex"
else
    print_ok "Codex CLI — already installed, skipping"
fi

sleep 1

# ═══════════════════════════════════════════════════════════════
#  Write .env file
# ═══════════════════════════════════════════════════════════════
ENV_FILE="$TUA_DIR/.env"
cat > "$ENV_FILE" << ENVFILE
# ╔══════════════════════════════════════════════════════════════╗
# ║         TUA AGENT — Environment Configuration                ║
# ║         Generated by setup.sh on $(date +%Y-%m-%d)                       ║
# ╚══════════════════════════════════════════════════════════════╝

# ═══════════════════════════════════════
# YOUR API KEY
# ═══════════════════════════════════════
OPENAI_API_KEY=$API_KEY

# ═══════════════════════════════════════
# SELECTED MODEL
# ═══════════════════════════════════════
TUA_MODEL=$SELECTED_MODEL

# ═══════════════════════════════════════
# OPTIONAL: Additional providers
# ═══════════════════════════════════════
# ANTHROPIC_API_KEY=
# GOOGLE_API_KEY=

# ═══════════════════════════════════════
# AUTO-DETECTED APPS
# ═══════════════════════════════════════
ENVFILE

# Detect installed apps
detect_app() {
    local app_name="$1"
    [ -d "/Applications/$app_name.app" ] && echo "true" || echo "false"
}

HAS_CHROME=$(detect_app "Google Chrome")
HAS_SAFARI=$(detect_app "Safari")
HAS_FIREFOX=$(detect_app "Firefox")
HAS_SLACK=$(detect_app "Slack")
HAS_VSCODE=$(detect_app "Visual Studio Code")
HAS_NOTION=$(detect_app "Notion")
HAS_FIGMA=$(detect_app "Figma")
HAS_DISCORD=$(detect_app "Discord")
HAS_TELEGRAM=$(detect_app "Telegram")
HAS_WHATSAPP=$(detect_app "WhatsApp")
HAS_DOCKER=$(command -v docker &>/dev/null && echo "true" || echo "false")

cat >> "$ENV_FILE" << ENVDETECTED
TUA_HAS_CHROME=$HAS_CHROME
TUA_HAS_SAFARI=$HAS_SAFARI
TUA_HAS_FIREFOX=$HAS_FIREFOX
TUA_HAS_SLACK=$HAS_SLACK
TUA_HAS_VSCODE=$HAS_VSCODE
TUA_HAS_NOTION=$HAS_NOTION
TUA_HAS_FIGMA=$HAS_FIGMA
TUA_HAS_DISCORD=$HAS_DISCORD
TUA_HAS_TELEGRAM=$HAS_TELEGRAM
TUA_HAS_WHATSAPP=$HAS_WHATSAPP
TUA_HAS_DOCKER=$HAS_DOCKER
ENVDETECTED

# ═══════════════════════════════════════════════════════════════
#  PHASE 6 — VERIFICATION
# ═══════════════════════════════════════════════════════════════
print_phase "PHASE 6/7 — Verification"

echo -e "  ${CYAN}Running final checks...${NC}"
echo ""

PASS=0
FAIL=0

verify() {
    local name="$1"
    local cmd="$2"
    if eval "$cmd" &>/dev/null; then
        print_ok "$name"
        PASS=$((PASS + 1))
    else
        print_fail "$name"
        FAIL=$((FAIL + 1))
    fi
}

verify "Git"                "command -v git"
verify "Node.js"            "command -v node"
verify "npm"                "command -v npm"
verify "Python3"            "command -v python3"
verify "pip3"               "command -v pip3"
verify "Playwright"         "python3 -c 'import playwright'"
verify "browser-use"        "python3 -c 'import browser_use'"
verify "Codex CLI"          "command -v codex"
verify ".env file"          "test -f '$TUA_DIR/.env'"
verify "CLAUDE.md"          "test -f '$TUA_DIR/CLAUDE.md'"
verify "API key set"        "test -n '$API_KEY'"

echo ""
echo -e "  ────────────────────────────────────"
echo -e "  ${GREEN}${BOLD}$PASS passed${NC}  ·  ${RED}${BOLD}$FAIL failed${NC}"
echo ""
sleep 1

# ═══════════════════════════════════════════════════════════════
#  PHASE 7 — DASHBOARD / LAUNCH MENU
# ═══════════════════════════════════════════════════════════════
print_phase "PHASE 7/7 — Setup Complete!"

echo -e "${CYAN}${BOLD}"
echo "  ╔════════════════════════════════════════════════════════════╗"
echo "  ║                                                            ║"
echo "  ║   ████████╗██╗   ██╗ █████╗     █████╗  ██████╗ ████████╗ ║"
echo "  ║      ██╔══╝██║   ██║██╔══██╗   ██╔══██╗██╔════╝    ██╔══╝ ║"
echo "  ║      ██║   ██║   ██║███████║   ███████║██║  ███╗   ██║    ║"
echo "  ║      ██║   ╚██████╔╝██║  ██║   ██╔══██║██║   ██║   ██║   ║"
echo "  ║      ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝  ╚═╝ ╚██████╔╝   ╚═╝ ║"
echo "  ║                                                            ║"
echo "  ║              ✅  INSTALLATION COMPLETE                     ║"
echo "  ║                                                            ║"
echo "  ╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "  ${BOLD}What would you like to do?${NC}"
echo ""
echo -e "  ${BOLD}1)${NC} 🚀 ${GREEN}Start TUA Agent${NC}         ${DIM}— Launch the AI agent (recommended)${NC}"
echo -e "  ${BOLD}2)${NC} 🖥️  ${CYAN}Launch Codex CLI${NC}        ${DIM}— OpenAI code assistant${NC}"
echo -e "  ${BOLD}3)${NC} 💬 ${GREEN}Connect WhatsApp${NC}        ${DIM}— Set up WhatsApp integration${NC}"
echo -e "  ${BOLD}4)${NC} 📱 ${BLUE}Connect Telegram${NC}        ${DIM}— Set up Telegram bot${NC}"
echo -e "  ${BOLD}5)${NC} 🎮 ${MAGENTA}Connect Discord${NC}        ${DIM}— Set up Discord bot${NC}"
echo -e "  ${BOLD}6)${NC} 💼 ${YELLOW}Connect Slack${NC}           ${DIM}— Set up Slack integration${NC}"
echo -e "  ${BOLD}7)${NC} 🌐 ${CYAN}Open Dashboard${NC}          ${DIM}— Web control panel${NC}"
echo -e "  ${BOLD}0)${NC} 🚪 ${DIM}Exit${NC}"
echo ""
echo -n "  Choice [0-7, default=1] → "
read -r LAUNCH_CHOICE < "$TTY"

cd "$TUA_DIR"

case "$LAUNCH_CHOICE" in
    2)
        echo ""
        echo -e "  ${CYAN}Starting Codex CLI...${NC}"
        echo -e "  ${DIM}(Use Ctrl+C to exit)${NC}"
        echo ""
        export OPENAI_API_KEY="$API_KEY"
        codex 2>/dev/null || {
            print_warn "Codex CLI not found. Run: npm install -g @openai/codex"
        }
        ;;
    3)
        echo ""
        echo -e "  ${GREEN}${BOLD}WhatsApp Setup:${NC}"
        echo ""
        echo -e "  1. Start the gateway:"
        echo -e "     ${CYAN}cd ../openclaw-main && pnpm install && openclaw onboard${NC}"
        echo -e "  2. Select 'WhatsApp' as the channel"
        echo -e "  3. Scan the QR code with your phone"
        echo ""
        ;;
    4)
        echo ""
        echo -e "  ${BLUE}${BOLD}Telegram Setup:${NC}"
        echo ""
        echo -e "  1. Create a bot via @BotFather on Telegram"
        echo -e "  2. Copy the bot token"
        echo -e "  3. Start the gateway:"
        echo -e "     ${CYAN}cd ../openclaw-main && pnpm install && openclaw onboard${NC}"
        echo -e "  4. Select 'Telegram' and paste your token"
        echo ""
        ;;
    5)
        echo ""
        echo -e "  ${MAGENTA}${BOLD}Discord Setup:${NC}"
        echo ""
        echo -e "  1. Create a bot at https://discord.com/developers/applications"
        echo -e "  2. Copy the bot token"
        echo -e "  3. Start the gateway:"
        echo -e "     ${CYAN}cd ../openclaw-main && pnpm install && openclaw onboard${NC}"
        echo -e "  4. Select 'Discord' and paste your token"
        echo ""
        ;;
    6)
        echo ""
        echo -e "  ${YELLOW}${BOLD}Slack Setup:${NC}"
        echo ""
        echo -e "  1. Create a Slack App at https://api.slack.com/apps"
        echo -e "  2. Copy the OAuth token"
        echo -e "  3. Start the gateway:"
        echo -e "     ${CYAN}cd ../openclaw-main && pnpm install && openclaw onboard${NC}"
        echo -e "  4. Select 'Slack' and paste your token"
        echo ""
        ;;
    7)
        echo ""
        echo -e "  ${CYAN}${BOLD}Starting Dashboard...${NC}"
        echo ""
        echo -e "  ${CYAN}cd ../openclaw-main && pnpm install && pnpm dev${NC}"
        echo -e "  ${DIM}Dashboard will open at http://localhost:3000${NC}"
        echo ""
        ;;
    0)
        echo ""
        echo -e "  ${DIM}Goodbye! Run ${NC}${BOLD}cd $TUA_DIR && claude .${NC}${DIM} when ready.${NC}"
        echo ""
        exit 0
        ;;
    *)
        echo ""
        echo -e "  ${GREEN}${BOLD}Starting TUA Agent...${NC}"
        echo -e "  ${DIM}(Type / to see 125+ available skills)${NC}"
        echo ""
        export OPENAI_API_KEY="$API_KEY"
        claude . 2>/dev/null || {
            echo ""
            echo -e "  ${YELLOW}Claude Code not found. Install it:${NC}"
            echo -e "  ${CYAN}npm install -g @anthropic-ai/claude-code${NC}"
            echo ""
            echo -e "  Then run: ${BOLD}cd $TUA_DIR && claude .${NC}"
        }
        ;;
esac

echo ""
echo -e "  ${GREEN}${BOLD}Thank you for using TUA Agent! 🤖${NC}"
echo ""
