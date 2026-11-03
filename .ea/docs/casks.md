# Casks

Facts as of 2026-11-03, read from `Casks/*.rb` and the commit history; re-check against the files before relying on a number.

| Cask | App | Source repository | Release asset | `depends_on` | Updated by |
|---|---|---|---|---|---|
| `nexus` | Nexus, macOS menu bar toolkit (Pomodoro, image uploader, time tracker, command palette) | `Lightblues/nexus` | `nexus-v<version>` release, `Nexus-<version>.dmg` | `:ventura` | CI on a stable tag |
| `nexus@beta` | the same app, rolling build of Nexus `main` | `Lightblues/nexus` | the moving `nexus-beta` release, `Nexus-<version>.dmg`, version `X.Y.Z-beta.N` | `:ventura` | CI on every build (about one commit per build, e.g. `nexus@beta: 1.3.1-beta.40`) |
| `erudite` | Erudite, SwiftUI app for GRE vocabulary | `Lightblues/erudite` | `erudite-v<version>` release, `Erudite-<version>.dmg` (universal) | `:sonoma` (SwiftUI `@Observable` needs macOS 14) | not determined: no workflow in the repositories on devcloud_cpu writes it; the cask comment says the first CI release of `Lightblues/erudite` rewrites the placeholder `sha256` (that repository is not cloned here) |

## How an update reaches the tap

1. In `Lightblues/nexus`, `.github/workflows/build.yml` builds the DMG, publishes it (a tagged `nexus-v<version>` release, or the moving prerelease `nexus-beta`), then checks out `lightblues/homebrew-tap` with the secret `TAP_PUSH_TOKEN`, **rewrites the whole cask file** (`Casks/nexus.rb` or `Casks/nexus@beta.rb`) from an inline template with the new `version` and `sha256`, and pushes as `github-actions[bot]`.
2. `update-tap.yml` in the same repository is the manual fallback: `gh workflow run update-tap.yml -f tag=nexus-vX.Y.Z` (only for tags starting with `nexus-v`).
3. `brew update` on a Mac picks it up; `livecheck` in `erudite.rb` follows the GitHub latest release.

Consequence: the cask files of Nexus are build output. Their fields (`name`, `desc`, `depends_on`, `conflicts_with`, `postflight`) are defined by the template in the nexus repository.

## Facts every cask shares

- Apps are ad-hoc signed; `postflight` runs `xattr -dr com.apple.quarantine` so Gatekeeper does not block the first launch.
- `auto_updates false`: the apps do not update themselves, Homebrew does.
- `nexus --zap` removes `~/.ea/nexus` (see the README's Uninstall section).
