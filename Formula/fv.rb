$pkg     = "github.com/kenshaw/fv"

class Fv < Formula
  desc "a command-line font viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/fv/archive/v0.5.7.tar.gz"
  sha256 "c67e505bec4bcd0dcf0eb97e638511d45a461fce1d6f79fec5088bcafb1802f9"

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
