# typed: false
# frozen_string_literal: true

class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  url "https://github.com/ichizero/connect-ktor/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "e099fbf0a57397b69375c20e46fe2c6b3623a7eb02bb6631e595923e2b7b56d7"

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
