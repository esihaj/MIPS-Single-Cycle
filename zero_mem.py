# -*- coding: utf-8 -*-
"""
Created on Sat Apr 04 15:28:44 2015

@author: Ehsan
"""

f_name = "inst.bin"
size = 4096;
word = 19;
to_write = "0" * word + "\n";
with open(f_name, "w") as f:
    for i in xrange(size):
        f.write(to_write)