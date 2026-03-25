class Periphery < Formula
  desc "Agent to connect with Komodo Core"
  homepage "https://komo.do"
  version "2.0.0"
  license "GPL-V3.0"

  on_macos do
    on_arm do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/periphery-apple"
      sha256 "25898267d549672654134063dc37634cccb9c11d961724839d1fd15f0c5fb83c"
    end

    on_intel do
      odie "The periphery formula does not provide a macOS Intel binary. Please use an Apple Silicon Mac or install on Linux."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/periphery-aarch64"
      sha256 "81052406a8baad114d26c2df98a20e73964ff11e301282639249c2979a5179a6"
    end

    on_intel do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/periphery-x86_64"
      sha256 "15f6834b2dbac0314807723a30292ef942841b310ba81f133fd80b2ca5e96fa7"
    end
  end

  resource "periphery-config" do
    url "https://raw.githubusercontent.com/moghtech/komodo/v#{version}/config/periphery.config.toml"
    sha256 "d1ef3295231b4d66ca62fd0a2f0c4f8206fc349c8b85dc851c2984ec5ca03bf7"
  end

  def install
    binary_name = if OS.mac?
      "periphery-apple"
    elsif Hardware::CPU.arm?
      "periphery-aarch64"
    else
      "periphery-x86_64"
    end

    bin.install binary_name => "periphery"

    resource("periphery-config").stage do
      (etc/"komodo").install "periphery.config.toml"
    end

    (var/"komodo").mkpath
    (var/"log/komodo").mkpath
  end

  service do
    run [opt_bin/"periphery", "--config-path", etc/"komodo/periphery.config.toml"]
    keep_alive true
    working_dir var/"komodo"
    log_path var/"log/komodo/periphery.log"
    error_log_path var/"log/komodo/periphery-error.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    # Test the installation
    system "#{bin}/periphery", "--version"
  end
end
