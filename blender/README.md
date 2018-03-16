# Blender script to reduce collision detection

## Generate a bounding box
Meshes are all assumed to have no `origin` tag.
```bash
<blender_executable> -b --python ${DEVEL_HPP_DIR}/src/hpp-tools/blender/bounding_box.py -- <meshfiles>
```
You can then copy-paste the content in the corresponding `collision` tag of your URDF file.

## Generate a simpler model
For now, only STL files are supported.
```bash
<blender_executable> -b --python ${DEVEL_HPP_DIR}/src/hpp-tools/blender/simplify_mesh.py -- -i <input> -o <output>
```
