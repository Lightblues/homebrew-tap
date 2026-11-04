# homebrew-tap

Personal Homebrew tap `lightblues/tap` for the user's macOS apps. Two casks: `nexus` (stable), `nexus@beta` (rolling build of Nexus main).
Most commits are made by `github-actions[bot]` from the Nexus repository's workflows; a human edits this repository rarely.

## Quick Reference

- **Use**: `brew tap lightblues/tap`, then `brew install --cask nexus` (or `nexus@beta`)
- **Where**: devcloud_cpu `/data/projects/app/homebrew-tap` (reference copy for coding agents; casks are only installable on a Mac)
- **Check a cask**: `brew audit --cask --online lightblues/tap/<name>` and `brew style Casks/` on a Mac; there is no CI here
- **Docs**: `.ea/docs/README.md` (how the casks are updated, per-cask facts), `.ea/roadmap.md`, `.ea/log/decisions.md`; layout follows forge-run `references/ea-layout.md`

## Rules

- `Casks/nexus.rb` and `Casks/nexus@beta.rb` are **generated** by `Lightblues/nexus` (`.github/workflows/build.yml` writes the whole file from a template on every build; `update-tap.yml` is the manual fallback; the push uses the secret `TAP_PUSH_TOKEN`). Any hand edit, including `name`, `desc`, `depends_on`, `conflicts_with`, is overwritten by the next run. Change the template in the nexus repository instead, and only then adjust the cask here to match. A wrong `sha256` breaks `brew install` for everyone.
- Every cask strips `com.apple.quarantine` in `postflight` because the apps are ad-hoc signed, not notarized (no Developer ID). Keep that block when adding a cask, and keep the README's "Notes on Unsigned Apps" in step.
- `nexus` and `nexus@beta` `conflicts_with` each other (set in the generator).
- `depends_on macos:` uses the symbol form (`:sonoma`, `:ventura`), not a version string (commit `a276b99`).
- A change to a cask's behavior (name, `depends_on`, `zap`, URL scheme) updates `.ea/docs/` in the same commit.

## Coding Style

- Ruby, Homebrew cask DSL, two-space indent; comments in English
