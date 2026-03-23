{
  description = "Build Aseprite (NixOS + Skia prebuilt)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        clang
        cmake
        ninja
        pkg-config
        python3
        gcc

        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXrandr
        xorg.libXinerama
        xorg.libXext
        xorg.libxcb   

        fontconfig
        freetype
        libGL
      ];

      shellHook = ''
        export CC=clang
        export CXX=clang++
        export CXXFLAGS="-stdlib=libstdc++"
        export LDFLAGS="-stdlib=libstdc++"

        export SKIA="${toString projectRoot}/../Skia-Linux-Release-x64/out/Release-x64"

        echo "Aseprite build env (generated with ChatGPT)"
      '';
    };
  };
}