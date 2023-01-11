#!/bin/bash

# estimates LTL using mosdepth median GC content
mosdepthFile=$1
mosdepthIndexFile=$2
gcBedFile=$3
gcBedIndexFile=$4
outputFile=$5


gcBedFile=/home/pankrat2/public/bin/ref/GRCh38_full_analysis_set_plus_decoy_hla.1kb.LTL.GC.filtered.bed.gz
mosdepthFile=/scratch.global/lanej/topMed/mosdepth.all/data/mosdepth/broad/WHI/NWD883937/NWD883937.by1000.regions.bed.gz

summarizeScript='vals = as.numeric(readLines ("stdin"))'
bedtools intersect -a $mosdepthFile -b $gcBedFile | cut -f4 |Rscript -e 'vals = as.numeric(readLines ("stdin"));data.frame(min = min(vals),max = max(vals),mean = mean(vals),sd = sd(vals),median = median(vals),mad = mad(vals),iqr = IQR(vals),n = length(vals))' \
|gzip>$outputFile