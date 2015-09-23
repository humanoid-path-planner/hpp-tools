from gepetto.corbaserver import Client
import gdb

class ForwardGeometry (gdb.Command):
    """
    forward-geometry <robotVariable> <configurationVariable>

    Send to the gepetto-viewer corba server the link positions of the robot <robotVariable>
    in the configuration <configurationVariable>.
    Both arguments must be accessible in the current context.
    """

    def __init__ (self):
        super (ForwardGeometry, self).__init__ ("forward-geometry", gdb.COMMAND_DATA, gdb.COMPLETE_EXPRESSION);

    def invoke (self, arg, from_tty):
        args = arg.split (" ")
        if len(args) is not 2:
            raise gdb.GdbError ("Expects 2 arguments. See \"help forward-geometry\"")
        command = "call hpp::model::forwardGeometry({0},{1})".format (args[0], args[1])
        print "Calling ", command
        gdb.execute (command, from_tty, True)
        val = gdb.history (0)

        start = val['_M_impl']['_M_start']
        finish = val['_M_impl']['_M_finish']
        end = val['_M_impl']['_M_end_of_storage']
        length = int (finish - start)

        print "%s links" % length

        cl = Client ()

        item = start
        while item != finish:
            current = item.dereference ()
            name = str(current["name"]["_M_dataplus"]["_M_p"].string())
            pos = [0,0,0,0,0,0,0]
            for i in range(3):
                pos[i] = float(current["p"][i])
            for i in range(4):
                pos[i+3] = float(current["q"][i])
            cl.gui.applyConfiguration (name, pos)
            item = item + 1
        cl.gui.refresh ()
        print "done"

ForwardGeometry ()
