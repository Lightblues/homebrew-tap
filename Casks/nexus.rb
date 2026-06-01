cask "nexus" do
  version "1.2.1"
  sha256 "8ff0696894e1e2ebbc2c2e93106a207932fd8b37d8b9889628a49591c576cb65"

  # Universal binary (arm64 + x86_64). Single DMG covers both architectures.
  url "https://github.com/Lightblues/nexus/releases/download/nexus-v#{version}/Nexus-#{version}.dmg"
  name "Nexus"
  desc "Menu bar toolkit — Pomodoro timer, image uploader, time tracker"
  homepage "https://github.com/Lightblues/nexus"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^nexus-v(\d+(?:\.\d+)+)$/i)
  end

  auto_updates false
  depends_on macos: ">= :ventura"   # Swift port requires macOS 13+

  app "Nexus.app"

  # The app is ad-hoc signed (no Apple Developer ID). Strip the quarantine
  # attribute so Gatekeeper doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nexus.app"],
                   sudo: false
  end

  zap trash: [
    "~/.ea/nexus",
    "~/Library/Application Support/Nexus",
    "~/Library/Caches/site.easonsi.nexus",
    "~/Library/Logs/Nexus",
    "~/Library/Preferences/site.easonsi.nexus.plist",
    "~/Library/Saved Application State/site.easonsi.nexus.savedState",
  ]
end
