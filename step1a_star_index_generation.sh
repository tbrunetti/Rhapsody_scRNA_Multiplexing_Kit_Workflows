#!/bin/bash

###################################################################################################################
# note: change the version of STAR to match the STAR version used in Rhaposdy Docker image; for v1.10, STAR is version 2.5.2b
# This only needs to be done one time per computer, unless a different version of Rhapsody Docker image is used and STAR has changed
wget https://github.com/alexdobin/STAR/archive/STAR_2.5.2b.tar.gz
tar -zxvf STAR_2.5.2b.tar.gz
###################################################################################################################


###################################################################################################################
# If using a small genome, i.e. bacterial or viral, be sure to update feature variable to match what is listed in gtf -- often times it will need to be "CDS".
# Additionally, bacterial and viral genomes tend to need manual updates made to gtf file
# If using a small genome you will also need to update the genomeSAindexNbases parameter to be smaller --see STAR manual for the calculation
# generate STAR genome and then create a gzipped tarball
star="/path/to/STAR/exebutable"
outputDir="/path/to/empty/directory/where/star/indicies/will/be/generated" # do not end in /
fasta="/path/to/genome.fasta"
gtf="/path/to/genome.gtf"
feature="exon"
readLength=75
genomeSAindexNbases=14


overhang=${readLength}-1
./STAR --runMode genomeGenerate --genomeDir ${outputDir}  --genomeFastaFiles ${fasta}  --sjdbGTFfile ${gtf} --sjdbGTFfeatureExon ${feature} --sjdbOverhang ${overhang} --genomeSAindexNbases ${genomeSAindexNbases}


tar -zcvf ${outputDir}".tar.gz" ${outputDir}

