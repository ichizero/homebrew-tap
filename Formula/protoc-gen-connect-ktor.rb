# typed: false
# frozen_string_literal: true

class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  url "https://github.com/ichizero/connect-ktor/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "c1683a3394a5a44d256029d84f255ca2a55d51771e9375d354d8c3bf34ba2495"

  bottle do
    root_url "https://github.com/ichizero/homebrew-tap/releases/download/protoc-gen-connect-ktor-0.4.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "53b551116c95369e8c437fe285dd729905e557d3d9acee043d6beb3ca5301507"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f74eea51f2f9c60e28c4af2bc9a3b3eb7a801df312fe58eee08607939d2f96fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "ff6c5088eb1dc49c307a1b20c5abab51f9bb74d2e732c907358d6ec485820064"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    cd "protoc-gen-connect-ktor" do
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X main.build=#{version}",
             "-o", "protoc-gen-connect-ktor", "./cmd/protoc-gen-connect-ktor"
      libexec.install "protoc-gen-connect-ktor"
    end

    # The Go entry point rejects positional arguments, so expose the
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
