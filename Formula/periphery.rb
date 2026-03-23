class Periphery < Formula
  desc "Agent to connect with Komodo Core"
  homepage "https://komo.do"
  version "1.19.5"
  license "GPL-V3.0"

  on_macos do
    on_arm do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/periphery-apple"
      sha256 "488913f9dde7c43afcac9cfbf3cabb5d858deecf08029a92a3809dd1f3bf35f5"
    end

    on_intel do
      odie "The periphery formula does not provide a macOS Intel binary. Please use an Apple Silicon Mac or install on Linux."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/periphery-aarch64"
      sha256 "682b280da2f09b5b6c0dc87d1cb511a35c930670e008808453f869a6892fe111"
    end

    on_intel do
      url "https://github.com/moghtech/komodo/releases/download/v#{version}/periphery-x86_64"
      sha256 "d6e89cb3602f7df7b64c43d35892c641578119c245196baed2857d7d07859470"
    end
  end

  resource "periphery-config" do
    url "https://raw.githubusercontent.com/moghtech/komodo/v#{version}/config/periphery.config.toml"
    sha256 "e593bd8df673fc210f70e4c767acc053b987d12cbd894f5925ed5c524ac4400c"
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
