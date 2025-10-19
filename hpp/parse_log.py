#!/usr/bin/env python
import os

devel_dir = os.getenv("DEVEL_HPP_DIR")


def parseStringInLog(pid, prefix):
    filename = devel_dir + "/install/var/log/hpp/journal." + pid + ".log"
    i = len(prefix)
    res = []
    with open(filename, "r") as f:
        for line in f:
            if line[:i] == prefix:
                res.append(line[i:])
    return res


def parseConfigInLog(pid, prefix):
    lines = parseStringInLog(pid, prefix)
    res = []
    for i in lines:
        q = map(float, filter(lambda x: x != "", i.strip("()\n").split(",")))
        res.append(q)
    return res
