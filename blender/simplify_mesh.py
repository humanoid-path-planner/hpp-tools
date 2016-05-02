import bpy, sys, getopt
import os.path

def usage ():
    print (os.path.basename(sys.argv[0]) + "-i <meshfile> -o <output>\n")
    print ("Arguments:")
    print ("\t-i meshfile      \t[mandatory]\tinput mesh file")
    print ("\t-o outmeshfile   \t[mandatory]\toutput mesh file")

try:
    opts, args = getopt.getopt (sys.argv[-4:], "i:o:", ["in=", "out="])
except getopt.GetoptError as err:
    usage ()
    print ("\nError: " + err.msg + "\n")
    raise

inMesh = None
outMesh = None
for opt, arg in opts:
    if opt in ("-i", "--in"):
        inMesh = arg
    elif opt in ("-o", "--out"):
        outMesh = arg

# For testing purpose
if inMesh is None:
    inMesh = "/local/jmirabel/devel/hpp/src/dlr_miiwa_urdf_model/lbr_iiwa/lbr_iiwa_description/meshes/coarse/link_1.stl"
if outMesh is None:
    outMesh = "/local/jmirabel/devel/hpp/src/dlr_miiwa_urdf_model/lbr_iiwa/lbr_iiwa_description/meshes/coarse/link_1_simplified.stl"

bpy.ops.import_mesh.stl(filepath=".", files=[{"name":inMesh}])
inVert = len(bpy.context.object.data.vertices)
bpy.ops.object.modifier_add(type='DECIMATE')
bpy.context.object.modifiers["Decimate"].decimate_type = 'DISSOLVE'
bpy.context.object.modifiers["Decimate"].angle_limit = 2 * 0.0872 # n * 5 degrees
bpy.context.object.modifiers["Decimate"].use_dissolve_boundaries = True
bpy.ops.object.modifier_apply(apply_as='DATA', modifier="Decimate")
outVert = len(bpy.context.object.data.vertices)
bpy.ops.export_mesh.stl(filepath=outMesh)
print("Number of vertices before:\t" + str(inVert))
print("Number of vertices after :\t" + str(outVert))
