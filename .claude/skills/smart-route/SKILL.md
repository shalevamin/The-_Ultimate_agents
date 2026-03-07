---
name: smart-route
description: Automatically route any task to the best available tool — without asking the user. Knows which apps are installed, which the user is logged into, and picks the optimal path. Use automatically whenever deciding HOW to do something (write docs, send email, create spreadsheet, manage code, etc.)
user-invocable: false
allowed-tools: Bash
---

# Smart Task Router

Automatically determine the best tool for any task based on what's available on this computer.

## ROUTING DECISION TREE

### 📄 DOCUMENT / WRITING TASKS

```bash
source ~/.tua-agent-env 2>/dev/null || true

route_document() {
    # Priority: Word > Google Docs > Notion > Markdown file
    if [ -d "/Applications/Microsoft Word.app" ]; then
        echo "ROUTE: Microsoft Word (installed locally)"
        echo "ACTION: open -a 'Microsoft Word'"
    elif pgrep -x "Google Chrome" >/dev/null; then
        echo "ROUTE: Google Docs (Chrome is running — likely logged in)"
        echo "ACTION: osascript -e 'tell app \"Google Chrome\" to open location \"https://docs.google.com/document/create\"'"
    elif [ -d "/Applications/Notion.app" ] || pgrep -x "Notion" >/dev/null; then
        echo "ROUTE: Notion (installed)"
        echo "ACTION: open -a 'Notion'"
    else
        echo "ROUTE: Markdown file (no doc app available)"
        echo "ACTION: Create file.md and open in default editor"
    fi
}
route_document
```

### 📊 SPREADSHEET TASKS

```bash
route_spreadsheet() {
    if [ -d "/Applications/Microsoft Excel.app" ]; then
        echo "ROUTE: Microsoft Excel"
        echo "ACTION: open -a 'Microsoft Excel'"
    elif pgrep -x "Google Chrome" >/dev/null; then
        echo "ROUTE: Google Sheets"
        echo "ACTION: osascript -e 'tell app \"Google Chrome\" to open location \"https://sheets.google.com/create\"'"
    elif command -v python3 >/dev/null; then
        echo "ROUTE: Python + pandas → CSV"
        echo "ACTION: python3 with pandas to create CSV"
    else
        echo "ROUTE: Markdown table"
    fi
}
```

### 📊 PRESENTATION TASKS

```bash
route_presentation() {
    if [ -d "/Applications/Keynote.app" ]; then
        echo "ROUTE: Keynote (Apple — native macOS)"
        echo "ACTION: open -a 'Keynote'"
    elif [ -d "/Applications/Microsoft PowerPoint.app" ]; then
        echo "ROUTE: Microsoft PowerPoint"
        echo "ACTION: open -a 'Microsoft PowerPoint'"
    elif pgrep -x "Google Chrome" >/dev/null; then
        echo "ROUTE: Google Slides"
        echo "ACTION: osascript -e 'tell app \"Google Chrome\" to open location \"https://slides.google.com/create\"'"
    else
        echo "ROUTE: /slides skill (markdown-based)"
    fi
}
```

### 💻 CODE TASKS

```bash
route_code() {
    # For coding tasks → use coding tools first
    if command -v claude >/dev/null; then
        echo "ROUTE: Claude Code (primary — best for complex tasks)"
        echo "ACTION: claude . (in project directory)"
    fi

    # Editor
    if [ -d "/Applications/Visual Studio Code.app" ]; then
        echo "EDITOR: VS Code"
        echo "ACTION: code ."
    elif [ -d "/Applications/Cursor.app" ]; then
        echo "EDITOR: Cursor (AI-powered)"
        echo "ACTION: cursor ."
    elif [ -d "/Applications/Windsurf.app" ]; then
        echo "EDITOR: Windsurf"
        echo "ACTION: windsurf ."
    fi
}
```

### 📧 EMAIL TASKS

```bash
route_email() {
    # Check if user has mail apps open
    if pgrep -x "Google Chrome" >/dev/null; then
        # Check if Gmail is open
        GMAIL_OPEN=$(osascript 2>/dev/null -e 'tell app "Google Chrome" to get URL of every tab of every window' | grep -c "gmail.com" || echo "0")
        if [ "$GMAIL_OPEN" -gt 0 ]; then
            echo "ROUTE: Gmail (already open in Chrome)"
            echo "ACTION: browser-use to compose email"
            return
        fi
    fi

    if [ -d "/Applications/Mail.app" ]; then
        echo "ROUTE: Apple Mail (installed)"
        echo "ACTION: open -a 'Mail'"
    elif [ -d "/Applications/Spark.app" ] || [ -d "/Applications/Airmail 5.app" ]; then
        echo "ROUTE: Third-party mail client"
    else
        echo "ROUTE: Gmail via browser"
        echo "ACTION: osascript -e 'tell app \"Chrome\" to open location \"https://mail.google.com\"'"
    fi
}
```

### 📅 CALENDAR TASKS

```bash
route_calendar() {
    if [ -d "/Applications/Calendar.app" ]; then
        echo "ROUTE: Apple Calendar (native)"
        echo "ACTION: AppleScript to Calendar.app"
    elif pgrep -x "Google Chrome" >/dev/null; then
        echo "ROUTE: Google Calendar"
        echo "ACTION: open location 'https://calendar.google.com'"
    fi
}
```

### 💬 MESSAGING TASKS

```bash
route_message() {
    local platform="$1"
    case "$platform" in
        "slack"|"Slack")
            pgrep -x "Slack" >/dev/null && echo "ROUTE: Slack app (running)" || echo "ROUTE: Slack web"
            ;;
        "discord"|"Discord")
            pgrep -x "Discord" >/dev/null && echo "ROUTE: Discord app (running)" || echo "ROUTE: Discord web"
            ;;
        "teams"|"Teams")
            [ -d "/Applications/Microsoft Teams.app" ] && echo "ROUTE: Teams app" || echo "ROUTE: Teams web"
            ;;
        *)
            echo "ROUTE: Default messaging (iMessage/SMS)"
            ;;
    esac
}
```

### 🖼️ IMAGE TASKS

```bash
route_image() {
    # Check API keys
    if [ -n "$ANTHROPIC_API_KEY" ]; then
        # Claude can describe/analyze images with vision
        echo "ROUTE: Claude Vision (analyze) + image-gen skill (create)"
    fi

    if [ -n "$OPENAI_API_KEY" ]; then
        echo "ROUTE: DALL-E 3 via image-gen skill (best quality)"
    fi

    if [ -n "$GOOGLE_API_KEY" ]; then
        echo "ROUTE: Google Imagen via image-gen skill"
    fi

    if [ -d "/Applications/Figma.app" ] || pgrep -x "Figma" >/dev/null; then
        echo "BONUS: Figma available for design work"
    fi
}
```

### 🎬 VIDEO TASKS

```bash
route_video() {
    REMOTION_DIR="$(find ~ -name 'remotion-main' -type d 2>/dev/null | head -1)"
    if [ -n "$REMOTION_DIR" ]; then
        echo "ROUTE: Remotion (programmatic video with React)"
        echo "ACTION: cd '$REMOTION_DIR' && npx remotion studio"
    elif command -v ffmpeg >/dev/null; then
        echo "ROUTE: FFmpeg (video processing)"
    else
        echo "ROUTE: /comic or /infographic skill (visual storytelling)"
    fi
}
```

### 🗂️ PROJECT MANAGEMENT TASKS

```bash
route_pm() {
    if pgrep -x "Google Chrome" >/dev/null; then
        # Check for PM tools in browser
        PM_TABS=$(osascript 2>/dev/null -e 'tell app "Google Chrome" to get URL of every tab of every window' || echo "")
        echo "$PM_TABS" | grep -q "linear.app" && echo "ROUTE: Linear (open in browser)" && return
        echo "$PM_TABS" | grep -q "notion.so" && echo "ROUTE: Notion (open in browser)" && return
        echo "$PM_TABS" | grep -q "github.com" && echo "ROUTE: GitHub Issues (open)" && return
        echo "$PM_TABS" | grep -q "jira" && echo "ROUTE: Jira (open)" && return
    fi

    [ -d "/Applications/Notion.app" ] && echo "ROUTE: Notion (installed)" && return
    command -v gh >/dev/null && echo "ROUTE: GitHub Issues via gh CLI" && return
    echo "ROUTE: /create-prd skill + markdown planning"
}
```

---

## FULL AUTO-ROUTE FUNCTION

```bash
# Call this with any task description
auto_route() {
    local task="$1"

    echo "🎯 Auto-routing task: $task"
    echo ""

    # Detect task type from keywords
    if echo "$task" | grep -qi "document\|write\|report\|memo\|doc\|article\|blog"; then
        route_document
    elif echo "$task" | grep -qi "spreadsheet\|excel\|table\|data\|csv\|sheet"; then
        route_spreadsheet
    elif echo "$task" | grep -qi "presentation\|slides\|deck\|keynote\|powerpoint"; then
        route_presentation
    elif echo "$task" | grep -qi "email\|mail\|send to\|inbox"; then
        route_email
    elif echo "$task" | grep -qi "calendar\|schedule\|meeting\|event\|remind"; then
        route_calendar
    elif echo "$task" | grep -qi "slack\|discord\|message\|chat"; then
        route_message "$task"
    elif echo "$task" | grep -qi "image\|picture\|photo\|generate\|create visual"; then
        route_image
    elif echo "$task" | grep -qi "video\|animation\|motion"; then
        route_video
    elif echo "$task" | grep -qi "code\|build\|develop\|program\|debug\|fix bug\|refactor"; then
        route_code
    elif echo "$task" | grep -qi "project\|task\|ticket\|issue\|sprint\|backlog"; then
        route_pm
    else
        echo "ROUTE: General — using Claude + computer control"
    fi
}

# Example usage:
# auto_route "write a document about our product strategy"
# auto_route "create a spreadsheet with Q4 numbers"
# auto_route "schedule a meeting for tomorrow"
```

---

## TASK: $ARGUMENTS

Run `auto_route "$ARGUMENTS"` to determine the best routing, then execute using the identified tool without asking the user to do anything manually.
