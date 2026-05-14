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
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-apple-darwin"
      sha256 "9512c76e56869ca5b5631dce83b14dfaf119c154d8786b25b02b90ba81b2d3da"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-apple-darwin"
      sha256 "2842b09cc95906819dcfb4fc4418bdd34465f7e29da8fad19e3425c7e8ad28e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-unknown-linux-musl"
      sha256 "38583d09d521ab96dcc1a8bf02918981aa03351fac7b64ffde2138ab3b725b87"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-unknown-linux-musl"
      sha256 "2bf50d6c96b7b5072b4a4f14b13c8d4300ab17faaa0b5ff0b65d2c6c9142d590"
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
