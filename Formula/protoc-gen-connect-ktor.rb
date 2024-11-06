class ProtocGenConnectKtor < Formula
  desc "Protoc plugin to generate Ktor server code"
  homepage "https://github.com/ichizero/connect-ktor"
  url "https://github.com/ichizero/connect-ktor/releases/download/v0.0.2/protoc-gen-connect-ktor"
  sha256 "3fb959b8bdffe3704ebc01ca84f012509cd308288fc81f80633fa18464f31c96"
  license "Apache-2.0"

  depends_on "openjdk" => :recommended

  def install
    libexec.install "protoc-gen-connect-ktor"
    (libexec/"protoc-gen-connect-ktor").chmod 0755
    (bin/"protoc-gen-connect-ktor").write_env_script libexec/"protoc-gen-connect-ktor", Language::Java.java_home_env
  end

  test do
    system "true"
  end
end
