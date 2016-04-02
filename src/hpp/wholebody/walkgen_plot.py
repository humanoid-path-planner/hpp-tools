import matplotlib.pyplot as plt
import numpy as np
import matplotlib.animation as animation

# To filter hpp logs, you can do:
# awk '/## Start foot steps - Python ##/ {p=1}; p; /## Stop foot steps - Python ##/ {p=0}' `ls -1t journal* | head -1` | \
#        sed "s/^[^ ]* //" > output.py
# # output.py file contains 3 variables: com, footPrint and timeParam
# python -i output.py
# > import hpp.wholebody
# > hpp.wholebody.walkgen_plot.plotComAnimation (com)
# > hpp.wholebody.walkgen_plot.plotFootPrintAnimation (footPrint)

def _blit_draw(self, artists, bg_cache):
    # Handles blitted drawing, which renders only the artists given instead
    # of the entire figure.
    updated_ax = []
    for a in artists:
        # If we haven't cached the background for this axes object, do
        # so now. This might not always be reliable, but it's an attempt
        # to automate the process.
        if a.axes not in bg_cache:
            # bg_cache[a.axes] = a.figure.canvas.copy_from_bbox(a.axes.bbox)
            # change here
            bg_cache[a.axes] = a.figure.canvas.copy_from_bbox(a.axes.figure.bbox)
        a.axes.draw_artist(a)
        updated_ax.append(a.axes)

    # After rendering all the needed artists, blit each axes individually.
    for ax in set(updated_ax):
        # and here
        # ax.figure.canvas.blit(ax.bbox)
        ax.figure.canvas.blit(ax.figure.bbox)

# MONKEY PATCH!!
animation.Animation._blit_draw = _blit_draw

# The journal log file can be parsed using the following command:
# awk '/## Start foot steps - Python ##/ {p=1}; p; /## Stop foot steps - Python ##/ {p=0}' journal.PID.log \
#        | sed "s/^[^ ]* //" > output.py
#
# Then, you can run:
# python -i output.py
# > import hpp.wholebody
# > hpp.wholebody.plotAll (time_param, footPrint, com)

def plotTimeParam (fig, axes, timeParam):
    for i in xrange(len(timeParam)):
        tmp = np.array(timeParam[i])
        axes.plot (tmp[:,0], tmp[:,1])

def plotFootStep (fig, axes, footPrint):
    handles = []
    for i in xrange(len(footPrint)):
        tmp = np.array(footPrint[i])
        handles.append(axes.plot (tmp[0::2,0], tmp[0::2,1], 'o ', label="Foot 0 - step " + str(i)))
        handles.append(axes.plot (tmp[1::2,0], tmp[1::2,1], label="Foot 1 - step " + str(i)))
    # axes.legend(handles=handles)

def subplotFootStep (footPrint):
    f, axarr = plt.subplots (len(footPrint), sharex=True, sharey=True)
    for i in xrange(len(footPrint)):
        tmp = np.array(footPrint[i])
        axarr[i].plot (tmp[0::2,0], tmp[0::2,1], '+ ', label="Foot 0")
        axarr[i].plot (tmp[1::2,0], tmp[1::2,1], 'x ', label="Foot 1")
        axarr[i].set_title ('Step ' + str(i))
    # axes.legend(handles=handles)

def plotCom (fig, axes, com):
    for i in xrange(len(com)):
        tmp = np.array(com[i])
        axes.plot (tmp[:,1], tmp[:,2])
    # axes.legend(handles=handles)

def plotComVersusTime (fig, axes, com):
    for i in xrange(len(com)):
        tmp = np.array(com[i])
        axes.plot (tmp[:,0], tmp[:,1], label="X COM - step " + str(i))
        axes.plot (tmp[:,0], tmp[:,2], label="Y COM - step " + str(i))
    axes.legend()

def subplotComVersusTime (Xaxes, Yaxes, com):
    for i in xrange(len(com)):
        tmp = np.array(com[i])
        Xaxes.plot (tmp[:,0], tmp[:,1], label="X COM - step " + str(i))
        Yaxes.plot (tmp[:,0], tmp[:,2], label="Y COM - step " + str(i))

def plotAll (timeParam, footPrint, com):
    fig = plt.gcf ()
    axes = fig.gca ()
    plotTimeParam(fig, axes, timeParam)

    # fig = plt.figure ()
    # axes = fig.gca ()
    # plotFootStep(fig, axes, footPrint)
    subplotFootStep(footPrint)

    fig = plt.figure ()
    axes = fig.gca ()
    plotCom (fig, axes, com)

    # fig = plt.figure ()
    # axes = fig.gca ()
    # plotComVersusTime (fig, axes, com)
    f, axarr = plt.subplots (2, sharex=True)
    subplotComVersusTime (axarr[0], axarr[1], com)

    plt.show()

def _updateAnimationData (i, data, t, Xcol, Ycol, title, ttl, line):
    ttl.set_text(title.format (i))
    tmp = np.array(data[i])
    if t is None:
        line.set_data (tmp[:,Xcol], tmp[:,Ycol])
    else:
        line.set_data (tmp[t,Xcol], tmp[t,Ycol])
    return line

def plotComAnimation (com, Xval=True, Yval=True):
    if Xval and Yval:
        Xcol = 1
        Ycol = 2
        title = "COM - step {0}"
    elif Xval:
        Xcol = 0
        Ycol = 1
        title = "X_COM - step {0}"
    elif Yval:
        Xcol = 0
        Ycol = 2
        title = "Y_COM - step {0}"
    else:
        return
    fig = plt.figure()
    ax = fig.gca()
    ttl = ax.text(.5, 1.05, '', transform = ax.transAxes, va='center')
    tmp = np.array(com[0])
    t = range(tmp.shape[0])
    line, = plt.plot (tmp[t,Xcol], tmp[t,Ycol], label="COM")
    line_ani = animation.FuncAnimation(fig, _updateAnimationData, len(com), fargs=(com,t,Xcol,Ycol,title, ttl,line), interval=1000, repeat_delay=3000)
    plt.show()

def plotFootPrintAnimation (footPrint):
    Xcol = 0
    Ycol = 1
    title = "Foot print - step {0}"
    fig = plt.figure()
    ax = fig.gca()
    ttl = ax.text(.5, 1.05, '', transform = ax.transAxes, va='center')
    tmp = np.array(footPrint[0])
    t = None
    line, = plt.plot (tmp[:,Xcol], tmp[:,Ycol], label="COM")
    line_ani = animation.FuncAnimation(fig, _updateAnimationData, len(footPrint), fargs=(footPrint,t,Xcol,Ycol,title, ttl,line), interval=1000, repeat_delay=3000)
    plt.show()
