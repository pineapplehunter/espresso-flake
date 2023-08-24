{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ self.overlays.default ]; };
    in
    {

      overlays.default = self: super: {
        espresso =
          pkgs.stdenv.mkDerivation rec {
            name = "espresso";
            version = "2.4";
            src = pkgs.fetchFromGitHub {
              owner = "chipsalliance";
              repo = "espresso";
              rev = "v${version}";
              sha256 = "sha256-z5By57VbmIt4sgRgvECnLbZklnDDWUA6fyvWVyXUzsI=";
            };

            nativeBuildInputs = with pkgs;[ cmake ];
          };
      };

      packages.x86_64-linux.espresso = pkgs.espresso;
      packages.x86_64-linux.default = self.packages.x86_64-linux.espresso;

      formatter.x86_64-linux = pkgs.nixpkgs-fmt;

    };
}
