cask "nexus" do
  arch arm: "arm64", intel: "x64"

  version "0.5.1"
  sha256 arm:   "0832584958796ccdfa63f46955e36f1ffda51a59d7e4434d3f5153583bca57f0",
         intel: "95e69d7ba569289e9a3ea2180b0dc8aea696cf649f09847875e0074d38e44d43"

  url "https://github.com/Lightblues/nexus/releases/download/nexus-v#{version}/Nexus-#{version}-#{arch}.dmg"
  name "Nexus"
  desc "Menu bar toolkit — Pomodoro timer, image uploader, time tracker"
  homepage "https://github.com/Lightblues/nexus"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^nexus-v(\d+(?:\.\d+)+)$/i)
  end

  auto_updates false
  depends_on macos: ">= :big_sur"

  app "Nexus.app"

  # The app is not signed with an Apple Developer ID. Strip the quarantine
  # attribute so macOS Gatekeeper doesn't block it on first launch.
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
