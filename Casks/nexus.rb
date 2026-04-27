cask "nexus" do
  arch arm: "arm64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "a8f181540f2cc10c7b25de6f1cc422e606847c5452fc822578b9db740bdbc344",
         intel: "c93026d3da0c744d5e9252b45f90b4475080c54eca930866e0b3c8caddb2cad8"

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
