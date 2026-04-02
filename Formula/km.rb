class Km < Formula
  desc "Cli to interact with Komodo Core"
  homepage "https://komo.do"
  url "https://github.com/moghtech/homebrew-komodo/releases/download/v2.1.1/km.tar.gz"
  sha256 "4b33896d62b70252279e88eecd8b0464b7e6552076c26a0f23e9cf44c05334a9"
  license "GPL-V3.0"

  def install
    bin.install "km"
  end

  test do
    # Test the installation
    system "#{bin}/km", "--version"
  end
end