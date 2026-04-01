class Km < Formula
  desc "Cli to interact with Komodo Core"
  homepage "https://komo.do"
  url "https://github.com/moghtech/homebrew-komodo/releases/download/v2.1.0/km.tar.gz"
  sha256 "d3e6e8f2c8e786e2ca22f921e542c17f9b2601ad5b9dddc0fef76d7e50885a51"
  license "GPL-V3.0"

  def install
    bin.install "km"
  end

  test do
    # Test the installation
    system "#{bin}/km", "--version"
  end
end