$pkg     = "github.com/kenshaw/fv"

class Fv < Formula
  desc "a command-line font viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/fv/archive/v0.4.12.tar.gz"
  sha256 "112737ccef42c0db8711c9ec7e65e549f315fb6d53660750d2e148d373496d07"

  depends_on "go" => :build

  def install
    (buildpath/"src/#{$pkg}").install buildpath.children

    cd "src/#{$pkg}" do
      system "go", "mod", "download"
      system "go", "build",
        "-trimpath",
        "-ldflags", "-s -w -X main.version=#{self.version}",
        "-o",       bin/"fv"
    end
  end

  test do
    output = shell_output("#{bin}/fv --version")
    assert_match "fv #{self.version}", output
  end
end
