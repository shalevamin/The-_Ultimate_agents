---
name: computer-use
description: Full computer control — mouse clicks, keyboard input, screenshots, application control, and GUI automation. Use when the user asks to click something, type something, take a screenshot, control an app, automate a workflow, or do anything on the computer. Also use when the user says "do this on screen", "click X", "open Y", "type Z", or any variant of controlling the computer.
allowed-tools: Bash
---

# Computer Use — Full Machine Control

You have **complete control** over this macOS computer. Use the tools below to control the mouse, keyboard, applications, and screen.

## WORKFLOW

1. **Understand** what the user wants to do on the computer
2. **Take a screenshot** first to see the current screen state
3. **Execute** the action using the appropriate method
4. **Verify** by taking another screenshot to confirm success
5. **Report** what was done

---

## TOOLS

### 📸 Screenshots (ALWAYS start here)

```bash
# Full screen screenshot
screencapture -x /tmp/tua-screen.png
```

After taking a screenshot, READ the image file to see what's on screen:
- Use Read /tmp/tua-screen.png to analyze the current state

### 🖱️ Mouse Control

```bash
# Move mouse to position (x, y)
osascript -e 'tell application "System Events" to set position of mouse cursor to {X, Y}'

# Click at position
osascript -e 'tell application "System Events" to click at {X, Y}'

# Double-click at position
osascript -e 'tell application "System Events" to double click at {X, Y}'

# Right-click at position
osascript -e 'tell application "System Events" to right click at {X, Y}'

# Click and drag
osascript -e '
tell application "System Events"
  click at {START_X, START_Y}
  key down
  set position of mouse cursor to {END_X, END_Y}
  key up
end tell'

# Scroll down/up at position
osascript -e 'tell application "System Events" to scroll by 3 at {X, Y}'
```

### ⌨️ Keyboard Control

```bash
# Type text
osascript -e 'tell application "System Events" to keystroke "YOUR TEXT HERE"'

# Press Enter
osascript -e 'tell application "System Events" to key code 36'

# Press Escape
osascript -e 'tell application "System Events" to key code 53'

# Press Tab
osascript -e 'tell application "System Events" to key code 48'

# Press Backspace/Delete
osascript -e 'tell application "System Events" to key code 51'

# Arrow keys (up=126, down=125, left=123, right=124)
osascript -e 'tell application "System Events" to key code 125'

# Common shortcuts
osascript -e 'tell application "System Events" to keystroke "c" using command down'  # Copy
osascript -e 'tell application "System Events" to keystroke "v" using command down'  # Paste
osascript -e 'tell application "System Events" to keystroke "a" using command down'  # Select All
osascript -e 'tell application "System Events" to keystroke "z" using command down'  # Undo
osascript -e 'tell application "System Events" to keystroke "s" using command down'  # Save
osascript -e 'tell application "System Events" to keystroke "q" using command down'  # Quit
osascript -e 'tell application "System Events" to keystroke "w" using command down'  # Close window
osascript -e 'tell application "System Events" to keystroke "t" using command down'  # New tab
osascript -e 'tell application "System Events" to keystroke "l" using command down'  # Address bar (browser)
osascript -e 'tell application "System Events" to keystroke "r" using command down'  # Refresh

# Multi-key shortcuts
osascript -e 'tell application "System Events" to keystroke "tab" using {command down, shift down}'  # Previous tab
```

### 🖥️ Application Control

```bash
# Open applications
open -a "Safari"
open -a "Google Chrome"
open -a "Firefox"
open -a "Finder"
open -a "Terminal"
open -a "Visual Studio Code"
open -a "Slack"
open -a "Mail"
open -a "Notes"
open -a "Keynote"
open -a "Pages"
open -a "Numbers"
open -a "Preview"
open -a "System Preferences"
open -a "System Settings"

# Open a file with default app
open /path/to/file

# Open URL in default browser
open "https://example.com"

# Focus a running application
osascript -e 'tell application "Safari" to activate'
osascript -e 'tell application "Google Chrome" to activate'

# Quit an application
osascript -e 'tell application "Safari" to quit'

# List running applications
osascript -e 'tell application "System Events" to get name of every process where background only is false'
```

### 🌐 Browser Control (AppleScript)

```bash
# Safari — navigate to URL
osascript -e 'tell application "Safari"
  activate
  open location "https://WEBSITE_URL"
end tell'

# Safari — get current URL
osascript -e 'tell application "Safari" to return URL of current tab of front window'

# Safari — get page content
osascript -e 'tell application "Safari" to return do JavaScript "document.title" in current tab of front window'

# Chrome — navigate
osascript -e 'tell application "Google Chrome"
  activate
  open location "https://WEBSITE_URL"
end tell'

# Chrome — get all tabs
osascript -e 'tell application "Google Chrome" to return URL of every tab of every window'

# Click a button by its text (using JavaScript in Chrome)
osascript -e 'tell application "Google Chrome" to execute front window active tab javascript "
  var buttons = document.querySelectorAll(\"button\");
  for(var b of buttons) {
    if(b.innerText.includes(\"BUTTON_TEXT\")) {
      b.click();
      break;
    }
  }
"'

# Fill a form field (using JavaScript in Chrome)
osascript -e 'tell application "Google Chrome" to execute front window active tab javascript "
  document.querySelector(\"input[name=FIELD_NAME]\").value = \"VALUE\";
"'
```

### 🔍 Find Elements on Screen

To find where to click, use screenshots + coordinate estimation:

```bash
# Take screenshot
screencapture -x /tmp/tua-screen.png

# Read the screenshot to analyze what's visible
# Then calculate approximate coordinates based on:
# - Screen resolution (usually 2560x1440 or 1920x1080 for Retina)
# - Element position in the image

# To get screen resolution
osascript -e 'tell application "Finder" to get bounds of window of desktop'

# To get mouse position
osascript -e 'tell application "System Events" to get position of mouse cursor'
```

### 🪟 Window Management

```bash
# Move window to position
osascript -e 'tell application "Safari" to set bounds of front window to {0, 23, 1200, 800}'

# Maximize window
osascript -e 'tell application "Safari"
  activate
  set bounds of front window to {0, 23, 2560, 1440}
end tell'

# Get window size and position
osascript -e 'tell application "Safari" to get bounds of front window'

# Minimize window
osascript -e 'tell application "Safari" to set miniaturized of front window to true'
```

### 📋 Clipboard

```bash
# Get clipboard content
osascript -e 'the clipboard'

# Set clipboard content
osascript -e 'set the clipboard to "YOUR TEXT"'

# Copy selected text
osascript -e 'tell application "System Events" to keystroke "c" using command down'
# Then get it:
osascript -e 'the clipboard'
```

### 🔔 System Dialogs & Notifications

```bash
# Show a dialog
osascript -e 'display dialog "MESSAGE" with title "TITLE" buttons {"OK"}'

# Show notification
osascript -e 'display notification "MESSAGE" with title "TUA AGENT" subtitle "SUBTITLE"'

# Ask user a question
osascript -e 'display dialog "QUESTION?" buttons {"Yes", "No"} default button "Yes"'

# Ask for text input
osascript -e 'display dialog "Enter value:" default answer "" with title "Tua Agent Input"'
```

### 🐍 Advanced: Python GUI Automation (PyAutoGUI)

For complex automation, use Python with PyAutoGUI:

```bash
# Install if needed (first time only)
pip3 install pyautogui pillow

python3 << 'PYTHON'
import pyautogui
import time

# Disable failsafe (move mouse to corner to stop)
pyautogui.FAILSAFE = True

# Take screenshot and save
screenshot = pyautogui.screenshot()
screenshot.save('/tmp/tua-pyautogui.png')

# Move mouse smoothly
pyautogui.moveTo(500, 300, duration=0.5)

# Click
pyautogui.click(500, 300)
pyautogui.doubleClick(500, 300)
pyautogui.rightClick(500, 300)

# Type with human-like speed
pyautogui.typewrite('Hello World', interval=0.05)

# Press key combinations
pyautogui.hotkey('command', 'c')  # Cmd+C
pyautogui.hotkey('command', 'v')  # Cmd+V
pyautogui.hotkey('command', 'a')  # Cmd+A

# Scroll
pyautogui.scroll(3, x=500, y=300)  # Scroll up 3 clicks

# Drag
pyautogui.drag(100, 0, duration=0.5)  # Drag 100 pixels right

# Find image on screen
# location = pyautogui.locateOnScreen('button.png', confidence=0.8)
# if location:
#     pyautogui.click(location)

print("Done!")
PYTHON
```

### 🌐 Browser Automation (Playwright)

For full web automation:

```bash
# Install if needed
pip3 install playwright
python3 -m playwright install chromium

python3 << 'PYTHON'
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    # Launch browser (headless=False to see it)
    browser = p.chromium.launch(headless=False)
    page = browser.new_page()

    # Navigate
    page.goto('https://example.com')

    # Click element
    page.click('button[type="submit"]')
    page.click('text=Login')

    # Fill form
    page.fill('input[name="email"]', 'user@example.com')
    page.fill('input[name="password"]', 'password')

    # Wait for element
    page.wait_for_selector('.dashboard')

    # Get text
    title = page.title()

    # Screenshot
    page.screenshot(path='/tmp/playwright.png')

    # Get full page text
    content = page.content()

    browser.close()
PYTHON
```

---

## EXAMPLES

### Example 1: Open Chrome and go to Google
```bash
open -a "Google Chrome"
sleep 1
osascript -e 'tell application "Google Chrome"
  activate
  open location "https://google.com"
end tell'
```

### Example 2: Type in currently focused field
```bash
osascript -e 'tell application "System Events" to keystroke "Hello, I am Tua Agent!"'
```

### Example 3: Take screenshot and analyze
```bash
screencapture -x /tmp/tua-screen.png
# Then: Read /tmp/tua-screen.png
```

### Example 4: Click the Finder icon in Dock
```bash
# Dock is at bottom of screen, Finder is usually first icon
# Standard screen: Finder at approximately x=75, y=1400 (for 1440p screen)
osascript -e 'tell application "System Events" to click at {75, 1440}'
```

### Example 5: Send a message in Slack
```bash
open -a "Slack"
sleep 2
# Take screenshot to see current state
screencapture -x /tmp/tua-screen.png
# Then click on message field and type
osascript -e 'tell application "System Events" to keystroke "Hello from Tua Agent!"'
osascript -e 'tell application "System Events" to key code 36'  # Press Enter
```

---

## IMPORTANT NOTES

1. **Always screenshot first** — Know what's on screen before clicking
2. **Coordinates are (x=horizontal, y=vertical)** from top-left corner
3. **Retina displays** have 2x pixel density — click coordinates may need adjustment
4. **Add delays** with `sleep 0.5` between actions when needed
5. **Accessibility must be enabled** for System Events keyboard/mouse control
   - System Settings → Privacy & Security → Accessibility → Enable Terminal/Claude
6. **For sensitive operations** (passwords, financial data) — stop and ask the user to do it themselves

---

## ENABLING ACCESSIBILITY (First time setup)

If mouse/keyboard control doesn't work, run:
```bash
osascript -e 'tell application "System Preferences"
  activate
  set current pane to pane "com.apple.preference.security"
end tell'
```
Then manually enable accessibility for Terminal in System Settings.
