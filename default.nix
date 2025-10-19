{
  lib,

  stdenv,

  # nativeBuildInputs
  cmake,
  python3Packages,

  # propagatedBuildInputs
  jrl-cmakemodules,
}:
stdenv.mkDerivation {
  pname = "hpp-tools";
  version = "0.0.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./bin
      ./blender
      ./CMakeLists.txt
      ./etc
      ./gdb
      ./hpp
      ./install
      ./package.xml
    ];
  };

  nativeBuildInputs = [
    cmake
    python3Packages.python
  ];

  propagatedBuildInputs = [
    jrl-cmakemodules
    python3Packages.numpy
  ];
}
