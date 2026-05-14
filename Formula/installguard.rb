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
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-apple-darwin"
      sha256 "3fe527883539e2a6b34050fe770d0ceedcb12a737c9398f179119d7d72c6bc0a"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-apple-darwin"
      sha256 "076f9bd3c50d00a64aff7d3c233a92e03344472596b2aa2ee0645b9ad04ff663"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-unknown-linux-musl"
      sha256 "797f62bd2241fb01c03338581c443cddc1b3300f19bffde2d1c5265e35618dfe"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-unknown-linux-musl"
      sha256 "34053f04f549fcce23be84134c0d3d775773f237e285d8a38063b6ab8e437cf9"
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
