$pkg     = "github.com/kenshaw/fv"

class Fv < Formula
  desc "a command-line font viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/fv/archive/v0.5.6.tar.gz"
  sha256 "f0dfcbf970d008d2f103e8658fdea0206ba56d94d44677cb7d3d0e78fd40c211"

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
