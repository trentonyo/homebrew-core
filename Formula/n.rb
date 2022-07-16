class N < Formula
  desc "Node version management"
  homepage "https://github.com/tj/n"
  url "https://github.com/tj/n/archive/v9.0.0.tar.gz"
  sha256 "37a987230d1ed0392a83f9c02c1e535a524977c00c64a4adb771ab60237be1c6"
  license "MIT"
  head "https://github.com/tj/n.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c48ce2cb10b7716d7eee3a22ed9cba603c8800bd673dfc9882daa8a26aea4024"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c48ce2cb10b7716d7eee3a22ed9cba603c8800bd673dfc9882daa8a26aea4024"
    sha256 cellar: :any_skip_relocation, monterey:       "1002532d9a95823156f2ea55ab16220dcb3ec57162b4fd807cead661f8234535"
    sha256 cellar: :any_skip_relocation, big_sur:        "1002532d9a95823156f2ea55ab16220dcb3ec57162b4fd807cead661f8234535"
    sha256 cellar: :any_skip_relocation, catalina:       "1002532d9a95823156f2ea55ab16220dcb3ec57162b4fd807cead661f8234535"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c48ce2cb10b7716d7eee3a22ed9cba603c8800bd673dfc9882daa8a26aea4024"
  end

  def install
    bin.mkdir
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"n", "ls"
  end
end
