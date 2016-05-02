import bpy, sys, getopt
import os.path

def usage ():
    print (os.path.basename(sys.argv[0]) + "<meshfiles>\n")
    print ("Arguments:")
    print ("\tmeshfiles     \t[mandatory]\tinput mesh file")

try:
    args = sys.argv[sys.argv.index("--")+1:]
    # opts, args = getopt.getopt (sys.argv[sys.argv.index("--")+1:], "i:", ["in="])
# except getopt.GetoptError as err:
    # usage ()
    # print ("\nError: " + err.msg + "\n")
    # raise
except ValueError:
    print ("You must add \"--\" without quotes before the arguments passed to the script.")
    raise

if len(args) is 0:
    usage()
    sys.exit(1)

bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete()

for f in args:
    name, ext = os.path.splitext(f)
    if ext == ".stl":
        bpy.ops.import_mesh.stl(filepath=".", files=[{"name":f}])
    elif ext == ".obj":
        bpy.ops.import_mesh.stl(filepath=f)
    elif ext == ".dae":
        bpy.ops.wm.collada_import(filepath=f)
    else:
        print("Unsupported extension. Please edit this script.")

def vectorToStr(v):
    return str(v[0]) + " " + str(v[1]) + " " + str(v[2])

bpy.ops.object.select_by_type(extend=True, type="MESH")
bpy.context.scene.objects.active = bpy.context.selected_objects[0]
bpy.ops.object.join()

bpy.ops.object.origin_set(type='ORIGIN_GEOMETRY', center='BOUNDS')

ob = bpy.context.object
print("============================================\n")
print("<origin xyz=\"" + vectorToStr(ob.location) + "\" rpy=\"" + vectorToStr(ob.rotation_euler) + "\" />")
print("<geometry>")
print("  <box size=\"" + vectorToStr(ob.dimensions) + "\" />")
print("</geometry>")
print("\n============================================")
