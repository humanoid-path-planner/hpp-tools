{
  description = "Tools for HPP";

  inputs.gepetto.url = "github:gepetto/nix";

  outputs =
    inputs:
    inputs.gepetto.lib.mkFlakoboros inputs (
      { lib, ... }:
      {
        overrideAttrs.hpp-tools = {
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
    );
}
