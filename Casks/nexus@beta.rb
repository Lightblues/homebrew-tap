cask "nexus@beta" do
  version "1.3.1-beta.32"
  sha256 "d42d9a0ee13e9d3b4a348d5d49665034cda0b593dd857338502dfe2633e02cfe"

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
