class Km < Formula
  desc "Cli to interact with Komodo Core"
  homepage "https://komo.do"
  version "1.19.5"
  license "GPL-V3.0"

  on_macos do
    on_arm do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/km-apple"
      sha256 "4b55696af5bc25ca85ea6b7d9a2192ee6d443b0536c7202b857baf4455e60db4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/km-aarch64"
      sha256 "ee6c87d6a3a711eae2a416ac73dbe35ef3c83aaa167ffcf074dea27045b9b242"
    end

    on_intel do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/km-x86_64"
      sha256 "0f8483d818a484c7abb4d64ee3ae769c528d22f245e7da1a2bf3fad7232679d9"
    end
  end

  def install
    binary_name = if OS.mac?
      "km-apple"
    elsif Hardware::CPU.arm?
      "km-aarch64"
    else
      "km-x86_64"
    end

    bin.install binary_name => "km"
  end

  test do
    # Test the installation
    system "#{bin}/km", "--version"
  end
end
