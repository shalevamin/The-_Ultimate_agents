---
name: remember
description: Save important information about the user, their preferences, projects, and context to persistent memory. Use proactively after learning anything new about the user — their name, preferences, project details, API keys status, installed apps, work style. Also use when the user says "remember this", "save this", "don't forget", or after completing a significant task. Memory persists across ALL sessions.
allowed-tools: Read, Edit, Write, Bash
---

# Remember — Persistent User Memory

Save information to long-term memory that persists across ALL Claude Code sessions.

## WHAT TO REMEMBER (proactively)
- User's name, language, location, timezone
- Project names and tech stacks
- App preferences (which IDE, browser, tools they use)
- API keys status (which are set, NOT the values)
- Past decisions and outcomes
- Things they explicitly say to remember
- Work style preferences

## HOW TO SAVE

### 1. Find the memory file
```bash
MEMORY_FILE="$(find ~ -name 'USER_PROFILE.md' -path '*tua-agent*' 2>/dev/null | head -1)"
echo "Memory file: $MEMORY_FILE"
```

### 2. Read current memory
```bash
cat "$MEMORY_FILE"
```

### 3. Update the relevant section
Use Edit tool to update the appropriate section in USER_PROFILE.md

### 4. For session summaries (add to bottom)
```bash
DATE=$(date +%Y-%m-%d)
# Append session summary
echo "" >> "$MEMORY_FILE"
echo "- [$DATE] $(SUMMARY_HERE)" >> "$MEMORY_FILE"
```

## MEMORY FILE LOCATION
`$TUA_AGENT_DIR/.memory/USER_PROFILE.md`
Where `TUA_AGENT_DIR` = the directory containing CLAUDE.md

## TASK: $ARGUMENTS

Save the following to memory: `$ARGUMENTS`

1. Read the current USER_PROFILE.md
2. Identify the right section to update
3. Add/update the information
4. Confirm: "✓ Remembered: [what was saved]"
