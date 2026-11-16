cask "nexus@beta" do
  version "1.3.1-beta.49"
  sha256 "78f5b8c6368263711a2da7837710ea4dddb35e285e5cc2947c0c05725baab3e9"

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
