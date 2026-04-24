cask "nexus" do
  arch arm: "arm64", intel: "x64"

  version "0.5.0"
  sha256 arm:   "87cf3a9c8b2c57a35ad5e0f668dba82a1a0d0ac193909ce12a9875d87c041168",
         intel: "e890379333dac8c2e96a6cc332e810ed2563cad25c547d335603f81c3a866482"

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
