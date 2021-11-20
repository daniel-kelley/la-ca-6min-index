#!/bin/sh
#
# Generate base map
#
# Projection:
#
# https://casetext.com/statute/california-codes/california-public-resources-code/division-8-surveying-and-mapping/chapter-1-california-coordinate-system/section-8807-zone-5-coordinates
#
# Zone 5 coordinates shall be named, and, on any map on which they are
# used, they shall be designated as "CCS27, Zone 5 or CCS83, Zone 5."
# On their respective spheroids of reference: (1) the standard
# parallels of CCS27, Zone 5 and CCS83, Zone 5 are at north latitudes
# 34 degrees 02 minutes and 35 degrees 28 minutes, along which
# parallels the scale shall be exact; and (2) the point of control of
# coordinates is at the intersection of the zone's central meridian,
# which is at 118 degrees 00 minutes west longitude, with the parallel
# 33 degrees 30 minutes north latitude.
#
# Lambert conic conformal -Jl lon0/lat0/lat1/lat2/scale|width
#    The longitude (lon0) and latitude (lat0) of the projection center.
#    The two standard parallels (lat1 and lat2).
#    The scale in plot-units/degree or as 1:xxxxx (with -Jl)


if [ $# -ne 1 ]
then
    echo $0 [output-file]
    exit 1
fi

name=`basename $1 .pdf`
# Lambert Conformal Conic
# See https://docs.generic-mapping-tools.org/6.2/cookbook/map-projections.html
proj=-Jl-118/33/34/33.5/1:500000

# Los Angeles Region
region=-R-119/-117.5/33.7/34.9

# area: large min to clip out various large bodies of water
area=-A5000/1/4

    # gmt pstext label.xyt $region $proj -F'+f10p'
gmt begin $name
    gmt basemap $region $proj -Bxg0.1d -Byg0.1d -Bx0.5 -By0.5
    gmt pstext la-ca-6min-name.xyt $region $proj -F'+f5p'
    gmt coast $area $region $proj -N1/,,.- -N2/,,.- -N3/,,.- -W
gmt end # show
