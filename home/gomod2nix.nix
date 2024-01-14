{ lib, ... }:

{
  home.file.".config/nixos/home/github.com/BurntSushi/toml" = {
    source = lib.fetchurl {
      url = "https://github.com/BurntSushi/toml/raw/main/example.toml";
      sha256 = "your-sha256-hash-here";
    };
  };

  home.file.".config/nixos/home/github.com/sirupsen/logrus" = {
    source = lib.fetchurl {
      url = "https://github.com/sirupsen/logrus/raw/master/example-file";
      sha256 = "your-sha256-hash-here";
    };
  };

  home.file.".config/nixos/home/golang.org/x/mod/modfile" = {
    source = lib.fetchurl {
      url = "https://github.com/golang/mod/raw/master/example-file";
      sha256 = "your-sha256-hash-here";
    };
  };

  home.file.".config/nixos/home/golang.org/x/mod/module" = {
    source = lib.fetchurl {
      url = "https://github.com/golang/module/raw/master/example-file";
      sha256 = "your-sha256-hash-here";
    };
  };

  home.file.".config/nixos/home/golang.org/x/tools/go/vcs" = {
    source = lib.fetchurl {
      url = "https://github.com/golang/tools/raw/master/example-file";
      sha256 = "your-sha256-hash-here";
    };
  };

  home.file.".config/nixos/home/github.com/spf13/cobra" = {
    source = lib.fetchurl {
      url = "https://github.com/spf13/cobra/raw/master/example-file";
      sha256 = "your-sha256-hash-here";
    };
  };
}
