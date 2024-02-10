{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "templ";
  src = pkgs.fetchurl {
    url =
      "https://github.com/a-h/templ/releases/download/v0.2.513/templ_Linux_x86_64.tar.gz";
    sha256 = "RglTZX5J9Qb5zQJBXg87riopDHuhAh5LuxPCQxfCI6o=";
  };

  installPhase = ''
    mkdir -p $out/bin
    tar -xzf $src -C $out/bin
    mv $out/bin/templ_Linux_x86_64 $out/bin/templ
  '';

  meta = with pkgs.lib; {
    description = "templ binary";
    homepage = "https://github.com/a-h/templ";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}

