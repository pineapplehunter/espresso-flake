{ fetchFromGitHub, cmake, stdenv }: stdenv.mkDerivation rec {
  pname = "espresso";
  version = "2.4";
  src = fetchFromGitHub {
    owner = "chipsalliance";
    repo = "espresso";
    rev = "v${version}";
    sha256 = "sha256-z5By57VbmIt4sgRgvECnLbZklnDDWUA6fyvWVyXUzsI=";
  };
  nativeBuildInputs = [ cmake ];
  enableParallelBuilding = true;
}
