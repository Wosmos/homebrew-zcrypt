cask "zcrypt" do
  arch arm: "arm64", intel: "x64"

  version :latest
  sha256 :no_check

  url "https://github.com/Wosmos/zcrypt/releases/latest/download/zcrypt-macos-#{arch}.dmg",
      verified: "github.com/Wosmos/zcrypt/"
  name "zcrypt"
  desc "Encrypted cloud storage on accounts you already own"
  homepage "https://zcrypt.cloud/"

  depends_on :macos

  app "zcrypt.app"

  # zcrypt isn't notarized yet, so clear the download quarantine flag or
  # macOS refuses to open it on first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/zcrypt.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/app.zcrypt.desktop",
    "~/Library/Caches/app.zcrypt.desktop",
    "~/Library/Logs/app.zcrypt.desktop",
    "~/Library/Preferences/app.zcrypt.desktop.plist",
    "~/Library/Saved Application State/app.zcrypt.desktop.savedState",
    "~/Library/WebKit/app.zcrypt.desktop",
  ]
end
