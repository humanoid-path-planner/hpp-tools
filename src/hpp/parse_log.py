#!/usr/bin/env python
import os
import numpy as np

devel_dir = os.getenv ('DEVEL_DIR')

def parseStringInLog (pid, prefix):
    filename = devel_dir + '/install/var/log/hpp/journal.' + pid + '.log'
    l = len (prefix)
    res = []
    with open (filename, 'r') as f:
        for line in f:
            if line [:l] == prefix:
                res.append (line [l:])
    return res

def parseVectorInLog (pid, prefix) :
    lines = parseStringInLog (pid, prefix)
    res = []
    for l in lines:
        v = map (float, filter (lambda x:x != '', l.strip ("\n").split (' ')))
        res.append (np.array (v))
    return res

def parseConfigInLog (pid, prefix):
    lines = parseStringInLog (pid, prefix)
    res = []
    for l in lines:
        q = map (float, filter (lambda x:x!='', l.strip ("\n").split(' ')))
        res.append (q)
    return res
