# 🤖 TUA AGENT — The Ultimate Agent

<div align="center">

```
████████╗██╗   ██╗ █████╗      █████╗  ██████╗ ███████╗███╗   ██╗████████╗
   ██╔══╝██║   ██║██╔══██╗    ██╔══██╗██╔════╝ ██╔════╝████╗  ██║   ██╔══╝
   ██║   ██║   ██║███████║    ███████║██║  ███╗█████╗  ██╔██╗ ██║   ██║
   ██║   ╚██████╔╝██║  ██║    ██╔══██║██║   ██║██╔══╝  ██║╚██╗██║   ██║
   ╚═╝    ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚██████╔╝███████╗██║ ╚████║   ╚═╝
```

**The most powerful AI agent ever assembled.**

Built from 12+ world-class open-source projects into one unstoppable tool.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-Ready-brightgreen.svg)]()
[![Skills](https://img.shields.io/badge/Skills-125%2B-blue.svg)]()
[![Agents](https://img.shields.io/badge/Agent_Personas-73-purple.svg)]()

</div>

---

## ⚡ One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/shalevamin/The-_Ultimate_agents/main/setup.sh | bash
```

That's it. The installer handles **everything** — permissions, dependencies, API key, model selection, and launches you into the agent.

---

## ⚠️ Warning

> **This is a dangerous tool.** TUA Agent gives an AI agent **full control** of your computer — mouse, keyboard, screen, browser, file system, and terminal. It is intended for **developers and power users only**. Use at your own risk.

---

## 🚀 What Does the Installer Do?

The one-line installer runs a **7-phase onboarding process**:

| Phase               | What Happens                                                                                                          |
| ------------------- | --------------------------------------------------------------------------------------------------------------------- |
| **1. Consent**      | ⚠️ Displays danger warning — you must type `I UNDERSTAND` to proceed                                                  |
| **2. System Scan**  | 🔍 Checks what's already installed (Homebrew, Node, Python, etc.) and skips what exists                               |
| **3. Permissions**  | 🔐 Pops up macOS dialogs for Accessibility, Screen Recording, and Admin access                                        |
| **4. API Key**      | 🔑 Prompts for your OpenAI API key + lets you pick a model (gpt-4o, o1, etc.)                                         |
| **5. Install**      | 📦 Installs only the missing dependencies (Homebrew, Node, Python, Playwright, Codex CLI)                             |
| **6. Verification** | ✅ Runs checks and shows a pass/fail summary                                                                          |
| **7. Launch Menu**  | 🚀 Presents a dashboard with options to start the agent, connect WhatsApp/Telegram/Discord/Slack, or launch Codex CLI |

---

## 📋 What is TUA Agent?

TUA Agent combines **12+ open-source projects** into a single AI agent that can do _anything_ on your computer:

| Capability                       | Description                                                            |
| -------------------------------- | ---------------------------------------------------------------------- |
| 🖱️ **Full Computer Control**     | Mouse, keyboard, screenshots — complete macOS automation               |
| 🌐 **Browser Automation**        | Controls Chrome with YOUR accounts (no login needed)                   |
| 🤖 **73 Agent Personas**         | Engineering, design, marketing, PM, testing, support specialists       |
| 🧠 **125+ Skills**               | Product strategy, content gen, code, image gen, web scraping, and more |
| 📡 **40+ Messaging Channels**    | WhatsApp, Telegram, Discord, Slack, Signal, iMessage, Teams, and more  |
| 🎬 **Video Creation**            | Programmatic video with React (Remotion)                               |
| 🏢 **Multi-Agent Orchestration** | Spawn and coordinate multiple AI agents in parallel                    |
| 📄 **Document Creation**         | PDF, Word, Excel, PowerPoint — auto-detects installed apps             |
| 🔍 **Web Scraping**              | Convert any URL to structured markdown                                 |
| 🎨 **AI Image Generation**       | DALL·E, Gemini, and more                                               |

---

## 💡 Usage

### Start the Agent

```bash
cd tua-agent
claude .
```

### Use Skills (125+)

Type `/` to see all available skills:

```
/computer-use       → Full mouse, keyboard, screen control
/orchestrate        → Multi-agent coordination
/image-gen          → AI image generation
/url-to-markdown    → Web scraping
/create-prd         → Product Requirements Doc
/business-model     → Business Model Canvas
/marketing-ideas    → Creative campaigns
/competitor-analysis → Market research
/cover-image        → AI cover images
/comic              → Knowledge comics
```

### Use Agent Personas (73)

```
"Act as the engineering-frontend-developer agent..."
"Use the marketing-growth-hacker approach..."
"Apply the testing-reality-checker framework..."
```

### Computer Control

```bash
# Take a screenshot
screencapture -x /tmp/screen.png

# Click anywhere on screen
osascript -e 'tell application "System Events" to click at {500, 300}'

# Type text
osascript -e 'tell application "System Events" to keystroke "Hello!"'

# Open any app
open -a "Safari"
```

### Connect Messaging Platforms

```bash
cd ../openclaw-main
pnpm install
openclaw onboard    # Interactive setup wizard
openclaw gateway    # Start receiving messages
```

---

## 🏗️ Architecture

```
tua-agent/                        ← YOU ARE HERE
├── CLAUDE.md                     ← Master agent brain (auto-loaded)
├── README.md                     ← This file
├── setup.sh                      ← One-line installer
├── .env                          ← API keys + auto-detected apps
└── .claude/
    ├── skills/                   ← 125+ skills
    │   ├── computer-use/         ← Full computer control
    │   ├── orchestrate/          ← Multi-agent coordination
    │   ├── native-browser/       ← browser-use + BrowserMCP
    │   ├── image-gen/            ← AI image generation
    │   ├── url-to-markdown/      ← Web scraping
    │   ├── create-prd/           ← Product Requirements
    │   ├── pdf/ docx/ xlsx/      ← Document creation
    │   └── ... (115+ more)
    └── agents/                   ← 73 agent personas
        ├── engineering-*.md
        ├── marketing-*.md
        ├── design-*.md
        └── ... (70+ more)

Parent Directory (supporting projects):
├── openclaw-main/                ← Gateway (40+ messaging channels)
├── browser-use/                  ← Python AI browser automation
├── browsermcp-main/              ← Native browser MCP
├── openai-codex-main/            ← OpenAI Codex
├── paperclip-master/             ← Multi-agent orchestration
├── remotion-main/                ← Programmatic video
├── agency-agents-main/           ← Agent persona source
├── anthropics-skills-main/       ← Anthropic skills
├── openai-skills-main/           ← OpenAI skills
├── pm-skills-main/               ← PM skills
├── naruto-skills-main/           ← Content gen skills
└── awesome-openclaw-skills-main/ ← 5,000+ community skills
```

---

## ⚙️ Configuration

### Environment Variables (`.env`)

| Variable            | Required | Description                                 |
| ------------------- | -------- | ------------------------------------------- |
| `OPENAI_API_KEY`    | ✅ Yes   | Your OpenAI API key (the only required key) |
| `TUA_MODEL`         | No       | Default AI model (set during install)       |
| `ANTHROPIC_API_KEY` | No       | For Claude-based features                   |
| `GOOGLE_API_KEY`    | No       | For Google Imagen/Gemini images             |

### Model Selection

Choose during installation or edit `.env`:

| Model         | Best For                            |
| ------------- | ----------------------------------- |
| `gpt-4o`      | Best quality + vision (recommended) |
| `gpt-4o-mini` | Faster, cheaper                     |
| `o1`          | Complex reasoning                   |
| `o1-mini`     | Fast reasoning                      |
| `gpt-4.1`     | Latest flagship                     |

---

## 🔒 Security & Permissions

| Permission           | Why Needed                  | How to Grant                                 |
| -------------------- | --------------------------- | -------------------------------------------- |
| **Accessibility**    | Mouse & keyboard control    | System Settings → Privacy → Accessibility    |
| **Screen Recording** | Screenshots for AI analysis | System Settings → Privacy → Screen Recording |
| **Admin (sudo)**     | Installing packages         | Password prompt during setup                 |

> All permissions are requested explicitly during setup with clear explanations. Nothing runs silently.

---

## 📋 Prerequisites

- **macOS** (tested on macOS 13+)
- **Terminal** (Terminal.app, iTerm2, or any terminal)
- **OpenAI API Key** ([Get one here](https://platform.openai.com/api-keys))
- **Internet connection** (for installation)

Everything else (Homebrew, Node.js, Python, etc.) is installed automatically if missing.

---

## 🤝 Contributors & Credits

TUA Agent is built on the shoulders of giants. This project combines and extends the following open-source projects:

### Core Frameworks

| Project              | Author / Org     | What It Contributes                                        | Link                                                 |
| -------------------- | ---------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| **OpenClaw**         | OpenClaw Team    | 40+ messaging channels, gateway, voice, browser automation | [GitHub](https://github.com/AltimateAI/openclaw)     |
| **browser-use**      | browser-use Team | Autonomous AI browser automation with Python               | [GitHub](https://github.com/browser-use/browser-use) |
| **BrowserMCP**       | BrowserMCP       | Native browser control via MCP (uses YOUR Chrome profile)  | [GitHub](https://github.com/anthropics/BrowserMCP)   |
| **OpenAI Codex CLI** | OpenAI           | AI-powered code assistant CLI                              | [GitHub](https://github.com/openai/codex)            |
| **OpenAI CUA**       | OpenAI           | Computer-Use Agent sample app                              | [GitHub](https://github.com/openai/cua-sample-app)   |

### Agent & Skills Libraries

| Project                        | Author / Org | What It Contributes                              | Link                                                              |
| ------------------------------ | ------------ | ------------------------------------------------ | ----------------------------------------------------------------- |
| **Agency Agents**              | Agency       | 73 specialized agent personas                    | [GitHub](https://github.com/agency-ai/agency-agents)              |
| **PM Skills**                  | PM Skills    | 65+ product management frameworks                | [GitHub](https://github.com/pm-skills/pm-skills)                  |
| **Naruto Skills**              | Naruto AI    | AI image gen, web scraping, comics, infographics | [GitHub](https://github.com/naruto-ai/naruto-skills)              |
| **Anthropic Skills**           | Anthropic    | PDF, DOCX, XLSX, Figma, webapp testing           | [GitHub](https://github.com/anthropics/anthropic-skills)          |
| **OpenAI Skills**              | OpenAI       | Playwright, Notion, Linear, deployment, security | [GitHub](https://github.com/openai/openai-skills)                 |
| **Awesome OpenClaw Skills**    | Community    | 5,000+ curated community skills                  | [GitHub](https://github.com/AltimateAI/awesome-openclaw-skills)   |
| **Awesome OpenClaw Use Cases** | Community    | 36+ real-world use case examples                 | [GitHub](https://github.com/AltimateAI/awesome-openclaw-usecases) |

### Infrastructure

| Project             | Author / Org | What It Contributes                            | Link                                                |
| ------------------- | ------------ | ---------------------------------------------- | --------------------------------------------------- |
| **Paperclip**       | Paperclip    | Multi-agent company orchestration with budgets | [GitHub](https://github.com/paperclip-ai/paperclip) |
| **Remotion**        | Remotion     | Programmatic video creation with React         | [GitHub](https://github.com/remotion-dev/remotion)  |
| **OpenViking**      | OpenViking   | Advanced AI workflows                          | [GitHub](https://github.com/openviking/openviking)  |
| **Apache Superset** | Apache       | Data exploration & visualization               | [GitHub](https://github.com/apache/superset)        |

### Built By

**Shalev Amin** — [@shalevamin](https://github.com/shalevamin)

Thank you to all the open-source contributors who made these projects possible. 🙏

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

<div align="center">

**🤖 TUA Agent — The Ultimate Agent**

_Built with ❤️ from 12+ open-source projects_

[⭐ Star this repo](https://github.com/shalevamin/The-_Ultimate_agents) · [🐛 Report Bug](https://github.com/shalevamin/The-_Ultimate_agents/issues) · [💡 Feature Request](https://github.com/shalevamin/The-_Ultimate_agents/issues)

</div>
