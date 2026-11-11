cask "nexus@beta" do
  version "1.3.1-beta.47"
  sha256 "002e935a3c9802d8d63e5b7022d95a79f657e22b01c6d3d044e45e82fca11dc4"

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
