##Changing the input cost 
#gdal_calc.py -A cost_raster.tif --outfile=cost_raster_fixed.tif --calc="A+1" --NoDataValue=-999
##gdal_calc.py \
##    -A Hansen_aus_cover_classes_compressed.tif \
##    --outfile=Hansen_specific_group.tif \
##    --calc="0*(A==1) + 1*(A==0) + 1*(A==2) + 2*(A==3) + 3*(A==4)" \
##    --NoDataValue=-999
##    #--calc="4*(A<5) + 3*(A>=5)*(A<10) + 2*(A>=10)*(A<30) + 1*(A>=30)*(A<70) + 0*(A>=70)*(A<100)" \
##
##gdal_translate \
##    -a_nodata -999 \
##    -co NUM_THREADS=ALL_CPUS -co COMPRESS=DEFLATE \
##    Hansen_specific_group.tif cost_raster.tif
#
#rm Hansen_specific_group.tif
#gdal_polygonize.py \
#    cost_raster.tif \
#    cost_raster.shp 
#
#ogr2ogr \
#    -nln area_polygons \
#    -lco SPATIAL_INDEX=GIST \
#    --config PG_USE_COPY YES \
#    -progress \
#    -nlt MULTIPOLYGON \
#    -lco GEOMETRY_NAME=geom \
#    -lco PRECISION=NO \
#    -where "\"DN\" = 0" \
#    -f "PostgreSQL" \
#    PG:"host=localhost port=5432 user=patrick dbname=postgis_db password=panorm12" \
#    cost_raster.shp 
#
#psql -U patrick -d postgis_db -h localhost -p 5432 -a -f query.sql
#
#ogr2ogr \
#    cleaned_patch_polygons.shp \
#    PG:"host=localhost port=5432 user=patrick dbname=postgis_db password=panorm12" "cleaned_patch_polygons"
#
#psql -U patrick -d postgis_db -h localhost -p 5432 -a -c "DROP TABLE area_polygons;"
#psql -U patrick -d postgis_db -h localhost -p 5432 -a -c "DROP TABLE cleaned_patch_polygons;"


Rscript Creating_random_spatial_points.R

#rm cost_raster.shp cost_raster.dbf cost_raster.prj cost_raster.shx
find . -name \*1.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*2.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*3.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*4.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'
    
find . -name \*5.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*6.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*7.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*8.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*9.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*10.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

find . -name \*11.shp  | parallel ' \
otbcli_Rasterization \
    -im cost_raster.tif \
    -ram 1500 \
    -in {} -out {.}.tif'

#Running the whitebox tools
python cost_distance_whitebox1.py
python cost_distance_whitebox2.py
python cost_distance_whitebox3.py
python cost_distance_whitebox4.py
python cost_distance_whitebox5.py
python cost_distance_whitebox6.py
python cost_distance_whitebox7.py
python cost_distance_whitebox8.py
python cost_distance_whitebox9.py
python cost_distance_whitebox10.py
python cost_distance_whitebox11.py

basename -s.tif cost_pathway*.tif | xargs -n1 -I % gdal_calc.py -A %.tif --outfile=%_fixed.tif --calc="A*(A>=0)" --NoDataValue=0
basename -s.tif cost_pathway*_fixed.tif | xargs -n1 -I % gdal_edit.py -unsetnodata %.tif

otbcli_BandMathX -il cost_pathway1_fixed.tif cost_pathway2_fixed.tif cost_pathway3_fixed.tif cost_pathway4_fixed.tif cost_pathway5_fixed.tif cost_pathway6_fixed.tif cost_pathway7_fixed.tif cost_pathway8_fixed.tif cost_pathway9_fixed.tif cost_pathway10_fixed.tif cost_pathway11_fixed.tif \
                -exp "sum(im1b1, im2b1, im3b1, im4b1, im5b1, im6b1, im7b1, im8b1, im9b1, im10b1, im11b1)" \
                -ram 10000 \
                -out cost_pathway_sum.tif

#gdal_edit.py -unsetnodata cost_pathway_sum.tif
#gdal_translate -a_nodata --2997 -co NUM_THREADS=ALL_CPUS -co COMPRESS=DEFLATE cost_pathway_sum.tif cost_pathway_sum_correct.tif

python smoothing_pathways.py

basename -s.tif *.tif | xargs -n1 -I % gdal_translate -co COMPRESS=DEFLATE -co NUM_THREADS=ALL_CPUS %.tif %_compressed.tif


#rm source1.tif source2.tif source3.tif destination1.tif destination2.tif destination3.tif cost_raster_compressed.tif

