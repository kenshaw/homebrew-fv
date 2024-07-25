$pkg     = "github.com/kenshaw/fv"

class Fv < Formula
  desc "a command-line font viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/fv/archive/v0.5.2.tar.gz"
  sha256 "b6bb3ac0f4e8a775ef0ee19e5c030d07a63df0921a5a04430c6e18d9e7e071ba"

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
