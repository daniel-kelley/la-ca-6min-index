#
#  Makefile
#
#  Copyright (c) 2021 by Daniel Kelley
#

OUTPUT := la-ca-6min-base-map.pdf
OUTPUT += la-ca-6min-name.xyt

.PHONY: all clean

all: $(OUTPUT)

la-ca-6min-base-map.pdf: gen.sh la-ca-6min-name.xyt la-county.xy
	./$< $@

# east was -117
la-ca-6min-name.xyt: extract-name
	./$< --scale=24000 --bounds="34.9,-119,33.5,-117.5" -i topomaps_all.csv --x-offset=0.05 --y-offset=0.05 --series="6min" -o $@

clean:
	-rm -f $(OUTPUT)
