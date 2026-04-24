# Lightblues Homebrew Tap

Personal Homebrew tap for [easonsi.site](https://easonsi.site) projects.

## Usage

```bash
brew tap lightblues/tap
brew install --cask nexus
```

Or in one shot:

```bash
brew install --cask lightblues/tap/nexus
```

## Available Casks

| Cask | Description |
|------|-------------|
| [`nexus`](Casks/nexus.rb) | macOS menu bar toolkit — Pomodoro timer, image uploader, time tracker |

## Notes on Unsigned Apps

The apps in this tap are **not signed with an Apple Developer ID** (no paid
developer account). To work around macOS Gatekeeper, each cask:

1. Expects the DMG to contain an **ad-hoc signed** `.app` bundle.
2. Runs `xattr -dr com.apple.quarantine` in `postflight` after install to
   strip the quarantine attribute, so the app opens without the
   "Apple could not verify..." dialog.

If you prefer not to trust this, install manually from
[GitHub Releases](https://github.com/Lightblues/nexus/releases) and decide
per-app whether to keep quarantine.

## Uninstall

```bash
brew uninstall --cask nexus          # remove app
brew uninstall --cask --zap nexus    # remove app + user data (~/.ea/nexus)
```
