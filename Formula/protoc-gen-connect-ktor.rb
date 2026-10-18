# typed: false
# frozen_string_literal: true

class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  url "https://github.com/ichizero/connect-ktor/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "c1683a3394a5a44d256029d84f255ca2a55d51771e9375d354d8c3bf34ba2495"

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
