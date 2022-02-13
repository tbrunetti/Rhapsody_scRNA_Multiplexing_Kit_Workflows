#!/bin/bash

######################################################################################
# for the sampleTags array, only list sample tags used in your library prep.  In the multiplexing kit, there are 12 possible sample tags and they would be denoted as:
# ST:Z:01, ST:Z:02, ST:Z:03, ST:Z:04, ST:Z:05, ST:Z:06, ST:Z:07, ST:Z:08, ST:Z:09, ST:Z:10, ST:Z:11, ST:Z:12
# replace the cellName1, cellName2, cellName3, cellName4, etc... with whatever string you want to call your sample associated with the tag; no spaces or special characters!!!!
######################################################################################


combinedBam="/path/to/combined_multiplexed-02102022_final.BAM"
samtools="/path/to/samtools"
declare -A sampleTags
sampleTags+=( ["cellName1"]="ST:Z:01" ["cellName2"]="ST:Z:06" ["cellName3"]="ST:Z:07" ["cellName4"]="ST:Z:08" )
outdir="/path/to/output/directory/"

# extract bam header
${samtools} view -H ${combinedBam} > ${outdir}"bamHeader.tmp"


for cellName in ${!sampleTags[@]};
do
	echo "Working on demultiplexing $cellName with sample tag ${sampleTags[${cellName}]}"
	${samtools} view ${combinedBam} | LC_ALL=C grep -F ${sampleTags[${cellName}]} > ${outdir}"bamAlignments.tmp"
	cat ${outdir}"bamAlignments.tmp" | sed 's/MA/UB/g' > ${outdir}"bamAlignmentsMod.tmp"
	cat ${outdir}"bamHeader.tmp" ${outdir}"bamAlignmentsMod.tmp" > "${outdir}"${cellName}"_sample_demux.sam"
	${samtools} view -bo "${outdir}"${cellName}"_sample_demux.bam" "${outdir}"${cellName}"_sample_demux.sam"
	${samtools} index "${outdir}"${cellName}"_sample_demux.bam"
	rm ${outdir}"bamAlignments.tmp"
	rm ${outdir}"bamAlignmentsMod.tmp"
	rm ${cellName}"_sample_demux.sam"
	echo "Finished demultiplexing $cellName with sample tag ${sampleTags[${cellName}]}"
done
