class Uv < Formula
  desc "Extremely fast Python package installer and resolver, written in Rust"
  homepage "https://github.com/astral-sh/uv"
  url "https://github.com/astral-sh/uv/archive/refs/tags/0.2.36.tar.gz"
  sha256 "a616b94ad80dc1b9759d7c38bf38e72894a496015623a2ca7a8f5f319e750d5f"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/astral-sh/uv.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "dc41662ea049f12860a859b13e0f70fd54aa07d88583679dea2712d9120013e5"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7e771b709a7bdda79314991d91bd5071769e3ae3475c0032a2e9ba1f300010ea"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b8f162e7ec24e9226e5b622ee023d28ad82876caaf404f3fd807574a1b88dbf9"
    sha256 cellar: :any_skip_relocation, sonoma:         "d3485da2be3444451a6fc22e0f10164762349e1f5e5f7dc55f71515d60ae2b24"
    sha256 cellar: :any_skip_relocation, ventura:        "f28c538776d718a808fd65d18f78ebde7c0a1677c921ab88b152e5d7a7899e6d"
    sha256 cellar: :any_skip_relocation, monterey:       "9398272e307821eaa08e6afdacec9e0e9f5c1ca3df973ab81f2876b52aad3569"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "766519797ad5ed6f7a29c138973a2db1ddbc8a94c0684c8c786c48d46841e19d"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  uses_from_macos "python" => :test
  uses_from_macos "xz"

  on_linux do
    # On macOS, bzip2-sys will use the bundled lib as it cannot find the system or brew lib.
    # We only ship bzip2.pc on Linux which bzip2-sys needs to find library.
    depends_on "bzip2"
  end

  def install
    ENV["UV_COMMIT_HASH"] = ENV["UV_COMMIT_SHORT_HASH"] = tap.user
    ENV["UV_COMMIT_DATE"] = time.strftime("%F")
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "crates/uv")
    generate_completions_from_executable(bin/"uv", "generate-shell-completion")
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      requests
    EOS

    compiled = shell_output("#{bin}/uv pip compile -q requirements.in")
    assert_match "This file was autogenerated by uv", compiled
    assert_match "# via requests", compiled

    assert_match "ruff 0.5.1", shell_output("#{bin}/uvx -q ruff@0.5.1 --version")
  end
end
