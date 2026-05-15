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
  version "0.1.13"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-apple-darwin"
      sha256 "ed165025773843f25d2810c85e7318d1d3b172f26a7ec8a766235ebf9d450aef"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-apple-darwin"
      sha256 "4f857c5951d5ca61fe458571c7033166d09918c3192a836ca72868e06a997c7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-unknown-linux-musl"
      sha256 "c47372217d5fc95fc9fe1d36e3532f426a422b134bffa3631faa8010447cf48d"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-unknown-linux-musl"
      sha256 "58a834e94bd1c735f3d6e396c301d493b36f9b3875053db6209cf9dbc74a2e50"
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
