self: super:

{
    fvim = super.stdenv.mkDerivation rec {
        pname = "fvim";
        version = "2023-05-11";

        src = super.fetchFromGitHub {
            owner = "yatli";
            repo = "fvim";
            rev = "2e4087de785da82e7140524e45b20bb53b6b073e";  # replace with the hash of the commit you want to build
            sha256 = "0dwhv6qa1821rya5k40xk2qwgshpijccbqfk1llii4xfrj8x5ncm";

        };

        buildInputs = with super; [ dotnet-sdk icu ];

        buildPhase = ''
            dotnet publish -f net6.0 -c Release -r linux-x64 --self-contained /p:PublishReadyToRun=false
        '';
        installPhase = ''
            mkdir -p $out/bin
            cp -r bin/Release/net6.0/linux-x64/publish/* $out/bin
        '';
    };
}