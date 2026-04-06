{
  description = "Tools for HPP";

  inputs = {
    gepetto.url = "github:gepetto/nix";
    flake-parts.follows = "gepetto/flake-parts";
    systems.follows = "gepetto/systems";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { lib, ... }:
      {
        systems = import inputs.systems;
        imports = [
          inputs.gepetto.flakeModule
          {
            flakoboros.overrideAttrs.hpp-tools = _: {
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
            };
          }
        ];
      }
    );
}
