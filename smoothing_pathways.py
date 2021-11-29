#%%
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 08:57:24 2020

@author: pat_n
"""
import os
import pkg_resources
import whitebox
import glob
import pandas as pd

abspath = os.path.realpath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

wbt = whitebox.WhiteboxTools()
print(wbt.version())
print(wbt.help())


print(dname)

source = dname + "/source1_compressed.tif"


cost_pathways_sum = dname + "/cost_pathway_sum.tif"
output_smoothed = dname + "/smoothed_sum_cost_pathways.tif"
#wbt.edge_preserving_mean_filter(
#    cost_pathways_sum, 
#    output_smoothed, 
#    filter=101, 
#    threshold=201
#)

#wbt.mean_filter(
#    cost_pathways_sum, 
#    output_smoothed, 
#    filterx=301, 
#    filtery=301
#)

wbt.gaussian_filter(
    cost_pathways_sum, 
    output_smoothed, 
    sigma=15
)

