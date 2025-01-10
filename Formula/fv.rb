$pkg     = "github.com/kenshaw/fv"

class Fv < Formula
  desc "a command-line font viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/fv/archive/v0.5.8.tar.gz"
  sha256 "601047e9be1bd8e4df1cbd154d6430bef48db867feb4ae80b8c38e3734ab5676"

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
