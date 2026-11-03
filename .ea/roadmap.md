# Roadmap

The tap is feature-complete for its three apps. Open questions only.

- **erudite**: the Swift app is parked (2026-11-03: may become a PWA). If it does, the `erudite` cask is retired; decide then whether to delete it or keep it as a legacy cask.
- **erudite CI**: the cask still carries a placeholder `sha256` comment; confirm that a tagged release of `Lightblues/erudite` really rewrites it, or drop the comment.
- **CI in this repository**: none. A `brew audit` / `brew style` job on pull requests would catch a bad bot commit; add it only if a bad commit ever happens.
