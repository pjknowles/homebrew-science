class Jmol < Formula
  homepage "http://www/jmol.org"
  url "https://downloads.sourceforge.net/jmol/Jmol/Version%2014.2/Version%2014.2.12/Jmol-14.2.12_2015.02.11-binary.zip"
  sha1 "f2f6f39b1c89d59ce624b3078ad19a0eef1f7d0f"

  head do
    url "https://jmol.svn.sourceforge.net/svnroot/jmol/trunk/Jmol"
    depends_on :ant
  end

  depends_on :java

  def install
    system "ant" if build.head?
    mv "jmol", "jmol.original"
    (buildpath/"jmol").write <<-EOS.undent
      #!/bin/sh
      JMOL_HOME=#{prefix} exec #{prefix}/jmol.sh "$*"
    EOS
    chmod "+x", %w[jmol jmol.sh]
    bin.install "jmol"
    prefix.install "jmol.sh", Dir["*.jar"]
    prefix.install Dir["build/*.jar"] if build.head?
  end

  test do
    system "true"
    # system "jmol", "-n" # unfortunately needs X11
  end
end

