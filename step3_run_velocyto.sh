#!/bin/bash

###############################################################
# If you haven't created a velocyto env or don't have it installed you can create it in code or just run the pip install code by uncommenting the lines below #
###############################################################
# For conda:
# conda create --name velocyto python=3.9
# conda activate velocyto
# conda install numpy scipy cython numba matplotlib scikit-learn h5py click
# pip install pysam
# pip install velocyto
# 
# For non-conda install on python3:
# conda install numpy scipy cython numba matplotlib scikit-learn h5py click
# pip install pysam
# pip install velocyto
#################################################################

# comment out if not using conda
conda activate velocyto

sampleDir="/path/to/dir/containing/all/demux/bam/files/" # must end in /
outdir="/path/to/dir/to/output/files/" # must end in /
listOfSamples="/path/to/samplesToProcess.txt"
gtf="/path/to/gtf/used/in/alignment.gtf"
threads=20

while read -r line;
do
	echo "Processing sample ${line}"
	velocyto run --samtools-threads $threads --outputfolder ${outdir} ${sampleDir}${line} ${gtf} 1> ${outDir}${line::-4}"_velocyto.log" 2> ${outDir}${line::-4}"_velocyto.err"
	echo "Finished processing sample ${line}"
done < ${listOfSamples}
