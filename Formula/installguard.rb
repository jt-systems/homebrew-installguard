# Homebrew formula for InstallGuard.
#
# This file is the source of truth that lives in the main repo; it is
# mirrored to `jt-systems/homebrew-installguard` (the tap repo) by the
# release workflow on every tagged version. See packaging/homebrew/README.md.
#
# The four sha256 values below are placeholders. The
# `mislav/bump-homebrew-formula-action` step in
# .github/workflows/release.yml rewrites the version + all four sha256
# values from the published release's checksums.txt on every `v*` tag.
class Installguard < Formula
  desc "Dependency freshness and install-script governance for npm/pnpm/yarn"
  homepage "https://github.com/jt-systems/installguard"
  version "0.1.12"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-apple-darwin"
      sha256 "adcce90cf9413980e20b9f559402810d4365ef7bd92cd69ce3bc019f75eea4e2"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-apple-darwin"
      sha256 "d82b2b152facd5de8a490b172c619e2ebca0798fa935cee43efb03251dc80c57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-unknown-linux-musl"
      sha256 "f497f7912183d45b85c7d8137b67942f6b37b75988ce4f1b2b02897143a7210e"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-unknown-linux-musl"
      sha256 "ea11174a0f3d89509c7f3b2c7ec105ac6ea56e222cb878a4d622bb32fc63705f"
    end
  end

  def install
    # The release workflow uploads pre-renamed binaries
    # (`installguard-<target-triple>`); install the one for this platform.
    binary = Dir["installguard-*"].first
    odie "no installguard-* binary found in download" if binary.nil?
    bin.install binary => "installguard"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/installguard --version")
  end
end
