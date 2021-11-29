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

source = dname + "/source1.tif"

cost = dname + "/cost_raster.tif"
#print(las_files)
out_accum = dname + "/out_accum1.tif"
out_backlink = dname + "/out_backlink1.tif"
wbt.cost_distance(
    source, 
    cost, 
    out_accum, 
    out_backlink
)
destination = dname + "/destination1.tif"
backlink = dname + "/out_backlink1.tif"
output = dname + "/cost_pathway1.tif"

wbt.cost_pathway(
    destination, 
    backlink, 
    output,
    zero_background=True
)

## %%
#cost_allocation = "/media/patrick/Patricks_HD/GER_and_Gondwanalink_report/GIS_layers/Aus_connectivity_trials/clipped_for_analysis/cost_allocation.tif"
#wbt.cost_allocation(
#    source, 
#    backlink, 
#    cost_allocation
#)
##%%
#cost_pathways_sum = "/media/patrick/Patricks_HD/GER_and_Gondwanalink_report/GIS_layers/Aus_connectivity_trials/clipped_for_analysis/sum_cost_pathways.tif"
#output_smoothed = "/media/patrick/Patricks_HD/GER_and_Gondwanalink_report/GIS_layers/Aus_connectivity_trials/clipped_for_analysis/smoothed_sum_cost_pathways.tif"
#wbt.olympic_filter(
#    cost_pathways_sum, 
#    output_smoothed, 
#    filterx=51, 
#    filtery=51
#)
# %%
