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
  version "0.2.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-apple-darwin"
      sha256 "fa9acbe2f5db5949ed192f55671fc0eb321b2d600bd28794af863ff276224cb6"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-apple-darwin"
      sha256 "bd6d6e973696fa00b437fb639b32a99786de75a9cd7128cec7bf4c8eb4a3308d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-aarch64-unknown-linux-musl"
      sha256 "345624f28b8aa5e891c56bfa31ffeb53812e2774c2a12a098a3952c227cf662d"
    end
    on_intel do
      url "https://github.com/jt-systems/installguard/releases/download/v#{version}/installguard-x86_64-unknown-linux-musl"
      sha256 "b5337e832811776d774d184da7495cd00cb87ad245432d803fd591b03ab9d085"
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
