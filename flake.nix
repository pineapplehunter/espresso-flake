{
  description = "A very basic flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          packages.espresso = pkgs.callPackage ./espresso.nix { };
          packages.default = packages.espresso;
          formatter = pkgs.nixpkgs-fmt;
        })
    // {
      overlays.default = final: prev: {
        inherit (self.packages.${final.system}) espresso;
      };
    };
}
