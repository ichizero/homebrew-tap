# typed: false
# frozen_string_literal: true

class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  url "https://github.com/ichizero/connect-ktor/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "89d1fc501fa50b3f6de5a37441780efd6c9ecd79606fd534ca088093c331c06d"

  bottle do
    root_url "https://github.com/ichizero/homebrew-tap/releases/download/protoc-gen-connect-ktor-0.4.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "8c291718ab5f590e85d4ffec2dd63cfcbb6b08fdf8141be6767cd3f8d647fd74"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "aab91666c5bba1776a79fefc0f2cf54d8c6dad7bb6821c4179bccd28d5981c24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "bea02f7f8844cd2ba162681db31596d23c61bf8a2cfd33b922ab763c91198937"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    cd "protoc-gen-connect-ktor" do
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X main.build=#{version}",
             "-o", "protoc-gen-connect-ktor", "./cmd/protoc-gen-connect-ktor"
      libexec.install "protoc-gen-connect-ktor"
    end

    # v0.4.0's Go entry point rejects positional arguments, so expose the
    # package version here and delegate protoc plugin invocations unchanged.
    (bin/"protoc-gen-connect-ktor").write <<~EOS
      #!/bin/sh
      if [ "$#" -eq 1 ] && [ "$1" = "--version" ]; then
        printf '%s\\n' 'protoc-gen-connect-ktor v#{version}'
        exit 0
      fi
      exec "#{opt_libexec}/protoc-gen-connect-ktor" "$@"
    EOS
    (bin/"protoc-gen-connect-ktor").chmod 0755
  end

  test do
    assert_equal "protoc-gen-connect-ktor v#{version}",
                 shell_output("#{bin}/protoc-gen-connect-ktor --version").strip

    # An empty CodeGeneratorRequest is valid and returns FEATURE_PROTO3_OPTIONAL.
    assert_equal [16, 1], shell_output("#{bin}/protoc-gen-connect-ktor < /dev/null").bytes
  end
end
