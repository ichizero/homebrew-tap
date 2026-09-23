# typed: false
# frozen_string_literal: true

class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  url "https://github.com/ichizero/connect-ktor/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "2fb096a14868933e4472e69700eceb0306dbbcd82f0af70fae13c41d0ea94352"

  bottle do
    root_url "https://github.com/ichizero/homebrew-tap/releases/download/protoc-gen-connect-ktor-0.3.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b649a8f3b785dff0c3d5435a0913c246963168db3db5d85cbb862a94583a975f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f22dd2f7a506f77004c5a5bedf55f5632885f98dd34528617934b52559160fe8"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    cd "protoc-gen-connect-ktor" do
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X main.build=#{version}",
             "-o", "protoc-gen-connect-ktor", "./cmd/protoc-gen-connect-ktor"
      libexec.install "protoc-gen-connect-ktor"
    end

    # v0.3.1's Go entry point rejects positional arguments, so expose the
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
