# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ichizero/connect-ktor/releases/download/v0.1.1/connect-ktor_Darwin_x86_64.tar.gz"
      sha256 "98bc91a09f1fd58d6029dbfaf06ad04061be9f1bc0863f2d535b241b60d45bf2"

      def install
        bin.install "protoc-gen-connect-ktor"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/ichizero/connect-ktor/releases/download/v0.1.1/connect-ktor_Darwin_arm64.tar.gz"
      sha256 "3ed766267f77653c14a405b7c30e475c18057875fbf54691d9452fca954989d4"

      def install
        bin.install "protoc-gen-connect-ktor"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://github.com/ichizero/connect-ktor/releases/download/v0.1.1/connect-ktor_Linux_x86_64.tar.gz"
      sha256 "71f2fcf1dff143de2e6783998a35f865ffff7eed6d0cb5ddf8a73ce652694a1e"
      def install
        bin.install "protoc-gen-connect-ktor"
      end
    end
    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://github.com/ichizero/connect-ktor/releases/download/v0.1.1/connect-ktor_Linux_arm64.tar.gz"
      sha256 "6cf122fd4c634cd08eb0ccbf62a4204a8d6549b8ab415e5f48b7fdd112a7fbea"
      def install
        bin.install "protoc-gen-connect-ktor"
      end
    end
  end
end
