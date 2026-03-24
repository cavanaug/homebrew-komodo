class Km < Formula
  desc "Cli to interact with Komodo Core"
  homepage "https://komo.do"
  url "https://github.com/moghtech/homebrew-komodo/releases/download/v2.0.0/km.tar.gz"
  sha256 "c16dfcd41ceec249dcc092cdab30b18aaf19333c5dc4ee1c143eaa647db53fc4"
  license "GPL-V3.0"

  def install
    bin.install "km"
  end

  test do
    # Test the installation
    system "#{bin}/km", "--version"
  end
end