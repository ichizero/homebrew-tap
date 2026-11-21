# typed: false
# frozen_string_literal: true

class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  url "https://github.com/ichizero/connect-ktor/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "e099fbf0a57397b69375c20e46fe2c6b3623a7eb02bb6631e595923e2b7b56d7"

  bottle do
    root_url "https://github.com/ichizero/homebrew-tap/releases/download/protoc-gen-connect-ktor-0.4.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0fff6a07d93aa25ad737b781bd7a024f5d280cfab34630c78a745a3102bad3fc"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "05690cade75f1a21251dbb59cc190f22437d910e6ee64df637cb323f1c9cb97e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "cd9e1d4f7393283ea7d169ba7e56f0f6ee206aa6c07d3ab3873443b43ed7ba72"
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
