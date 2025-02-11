# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  version "0.0.5"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ichizero/connect-ktor/releases/download/v0.0.5/connect-ktor_Darwin_x86_64.tar.gz"
      sha256 "8f2599047f5730f4bd9ef4050fec834772061d9b0f955b1d7c1ca807c7e60107"

      def install
        bin.install "protoc-gen-connect-ktor"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/ichizero/connect-ktor/releases/download/v0.0.5/connect-ktor_Darwin_arm64.tar.gz"
      sha256 "fed02c80af8539af2fd6fa0d691ef01450a49499297394b1d0f30add35a9b1a1"

      def install
        bin.install "protoc-gen-connect-ktor"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/ichizero/connect-ktor/releases/download/v0.0.5/connect-ktor_Linux_x86_64.tar.gz"
        sha256 "442f7db74cf5e0e3bc309fa1b5a40c8c6fe3112b11c7854d6c145224bed9a144"

        def install
          bin.install "protoc-gen-connect-ktor"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/ichizero/connect-ktor/releases/download/v0.0.5/connect-ktor_Linux_arm64.tar.gz"
        sha256 "ada5b62e8ed35dba9c6cb914db608070f1b3947412b2acf9c215f53468a6d473"

        def install
          bin.install "protoc-gen-connect-ktor"
        end
      end
    end
  end
end
