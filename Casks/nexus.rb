cask "nexus" do
  arch arm: "arm64", intel: "x64"

  version "0.7.0"
  sha256 arm:   "d4f3a4d65df8a543a5678d3ebee1530daeba130bf80db6f71e27522b1f6b59bb",
         intel: "db22aecf84cda34cf7e31c831eda7012c4bfb4893c4d1f611e82446959fd8c5a"

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
