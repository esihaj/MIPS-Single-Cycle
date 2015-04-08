# -*- coding: utf-8 -*-
"""
Created on Sat Apr 04 15:28:44 2015

@author: Ehsan
"""
import random
f_name = "mem2.bin"
size = 256;
word = 8;
to_write = "0" * word + "\n";
num_arr = [random.randint(0,255) for x in xrange(20)]
bin_arr =  ['{s:{c}>{n}}'.format(s=bin(x)[2:],n=8,c='0') for x in num_arr]
print num_arr
with open(f_name, "w") as f:
    for i in xrange(100):
        f.write(to_write)
    for i in bin_arr:
        f.write(i+"\n")
    for i in xrange(120, size):
        f.write(to_write)