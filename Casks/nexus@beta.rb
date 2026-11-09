cask "nexus@beta" do
  version "1.3.1-beta.43"
  sha256 "26918429724ebb7c6be8a2a5e901cd1104c2fc803f8ae965ec7f5d570ab42b2c"

  url "https://github.com/Lightblues/nexus/releases/download/nexus-beta/Nexus-#{version}.dmg"
  name "Nexus (beta)"
  desc "Rolling build of Nexus main: Pomodoro timer, time tracker, command palette"
  homepage "https://github.com/Lightblues/nexus"

  auto_updates false
  conflicts_with cask: "nexus"
  depends_on macos: :ventura

  app "Nexus.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nexus.app"],
                   sudo: false
  end
end
