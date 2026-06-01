cask "erudite" do
  version "1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  # Universal binary (arm64 + x86_64). Single DMG covers both architectures.
  # The all-zero sha256 is a placeholder; the first CI release will rewrite it.
  url "https://github.com/Lightblues/erudite/releases/download/erudite-v#{version}/Erudite-#{version}.dmg"
  name "Erudite"
  desc "AI-native macOS app for GRE vocabulary learning"
  homepage "https://github.com/Lightblues/erudite"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^erudite-v(\d+(?:\.\d+)+)$/i)
  end

  auto_updates false
  depends_on macos: ">= :sonoma"   # SwiftUI @Observable requires macOS 14+

  app "Erudite.app"

  # The app is ad-hoc signed (no Apple Developer ID). Strip the quarantine
  # attribute so Gatekeeper doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Erudite.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Erudite",
    "~/Library/Caches/site.easonsi.Erudite",
    "~/Library/Logs/Erudite",
    "~/Library/Preferences/site.easonsi.Erudite.plist",
    "~/Library/Saved Application State/site.easonsi.Erudite.savedState",
  ]
end
