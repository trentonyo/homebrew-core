class GitCola < Formula
  include Language::Python::Virtualenv

  desc "Highly caffeinated git GUI"
  homepage "https://git-cola.github.io/"
  url "https://files.pythonhosted.org/packages/21/13/24757dd737e347c4a528ee467568ad32b7afbca704e6e55945d2f7b9ddd6/git-cola-4.6.1.tar.gz"
  sha256 "b9dd4b7026a21c79918a4f6b07c19ac11717379f43f218f65d928e89a906cbf4"
  license "GPL-2.0-or-later"
  head "https://github.com/git-cola/git-cola.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "916692f1dfd8c0053f240183af0a0b46525c4408ae0ce2ca76f030d5b6a764e6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "14d326628b3948f4ef0b7fbae75c9440359d44e5f7aa21459348eb71186450a5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4909fa235b3ef2d555ed22171fbb43b472c74fe7680d8d08b95cc8f685ab365f"
    sha256 cellar: :any_skip_relocation, sonoma:         "90f90d2728dd4fb086dc606d222c57eefd02fe7eed5143ae8c7fef7130ec07a3"
    sha256 cellar: :any_skip_relocation, ventura:        "5a9351cb74f320384a8ef7a8053989d23be0e147179b53e2ff58c16f3b5dafb9"
    sha256 cellar: :any_skip_relocation, monterey:       "8ebf6999bbacc7c9e7486abc44d45557777fbf31828edd1e0888565900bbbba5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "824e0809937a561ce95413e3f06cb5a9104219e1ef1c9cc29cc71cfb2eaa6e60"
  end

  depends_on "pyqt"
  depends_on "python@3.12"

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/fb/2b/9b9c33ffed44ee921d0967086d653047286054117d584f1b1a7c22ceaf7b/packaging-23.2.tar.gz"
    sha256 "048fb0e9405036518eaaf48a55953c750c11e1a1b68e0dd1a9d62ed0c092cfc5"
  end

  resource "polib" do
    url "https://files.pythonhosted.org/packages/10/9a/79b1067d27e38ddf84fe7da6ec516f1743f31f752c6122193e7bce38bdbf/polib-1.2.0.tar.gz"
    sha256 "f3ef94aefed6e183e342a8a269ae1fc4742ba193186ad76f175938621dbfc26b"
  end

  resource "qtpy" do
    url "https://files.pythonhosted.org/packages/eb/9a/7ce646daefb2f85bf5b9c8ac461508b58fa5dcad6d40db476187fafd0148/QtPy-2.4.1.tar.gz"
    sha256 "a5a15ffd519550a1361bdc56ffc07fda56a6af7292f17c7b395d4083af632987"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"git-cola", "--version"
  end
end
