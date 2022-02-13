# Rhapsody_scRNA_Multiplexing_Kit_Workflows
Workflows to help facilitate demultiplexing and analysis for scRNA-seq libraries generated with BD Sciences Rhapsody Multiplexing Kit

First, clone this repository to get some of the bash scripts and other custom scripts  
```
git clone https://github.com/tbrunetti/Rhapsody_scRNA_Multiplexing_Kit_Workflows.git   
```

</br>

## STEP0: Overall fastq quality
**for libraries where cDNA is generated and mixed in same library as sample tag**  

### Software Dependencies  
* fastqc  

</br>  

## STEP1: General Demultiplexing and Alignment  
**for libraries where cDNA is generated and mixed in same library as sample tag**  

### Software Dependencies  
* Docker  
* python v2.7 due to Rhapsody issues with python v3 with `cwl-runner` installed 
* STAR aligner matching Rhapsody Docker version (v1.10 is STAR v2.5.2b)  

### Input of STEP1  

### Output of STEP1  
 

</br>  

## STEP2: Demultiplex Combined Alignment and Modification for `velocyto` compatibility
**for libraries where cDNA is generated and mixed in same library as sample tag**  

### Software Dependencies  
* bash version >=4.0  
* samtools  

### Input of STEP2  
* combined bam file output in STEP1  

### Output of STEP2  
* .bam alignment file ready for use in velocyto (1 per sample demuxed)  
* .bai index file, in case needed later for softwares such as IGV (1 per sample demuxed)  


</br>  

## STEP3: Setup and run `velocyto` using the custom run commands  
**for libraries where cDNA is generated and mixed in the same library as sample tag**  

### Software Dependencies  
* python >v3.6, I use python v3.9  
* velocyto with dependencies installed  

### Input of STEP3  
* .bam file(s) produced in STEP2 

### Output of STEP3  
* .loom file (1 per bam)  
* .log file (1 per bam)  
* .err file (1 per bam)  
 

</br>


## STEP4: Downstream analysis in `Seurat` using `velocyto` for RNA velocity  

### Software Dependencies  
* Seurat  
* SeuratWrappers  
* velocyto.R  

### Input of STEP4:  
* .loom file from STEP3  




</br>  


