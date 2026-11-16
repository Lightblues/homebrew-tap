cask "nexus@beta" do
  version "1.3.1-beta.51"
  sha256 "e41df808f219878c72fcef8444534173aa1cf564a8227e12ea4202dca52c4ee1"

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
