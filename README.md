# Rhapsody_scRNA_Multiplexing_Kit_Workflows
Workflows to help facilitate demultiplexing and analysis for scRNA-seq libraries generated with BD Sciences Rhapsody Multiplexing Kit

First, clone this repository to get some of the bash scripts and other custom scripts  
```
git clone https://github.com/tbrunetti/Rhapsody_scRNA_Multiplexing_Kit_Workflows.git   
```
Then download the version of BDsciences Rhapsody config files  you want to use.  This github page assumes you are using v1.10:   
1.  Go to https://bitbucket.org/CRSwDev/cwl/src/master/  
2.  Download the repository by selecting the dowload button on the left side panel.  
3.  This will download all the configuration files you need for Docker.  You will see `.cwl` and `.yml` files. For our purpose, we will be using `v1.10`  

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
* conda/anaconda/virtualenv  

### Setting up Environment  
Once Docker is installed, pull the latest docker image from the Rhapsody repo (you may need `sudo` permissions to pull the image if you are not on your own personal computer):  
```  
docker pull bdgenomics/rhapsody  
```  

You will also need `python v2.7` installed since BD genomics has not yet updated their Docker image to be compatible with `python v3`.  **Warning!** python v2.7 is deprecated -- **I would strongly recommend building this locally or using `conda` or `virutalenv` to keep this build separate from the current python versions.**  
To build python 2.7 within a `conda` environment ready for use with Rhapsody Docker images:  
1. Create a python environment -- I am going to call mine `py2` but you can call it whatever you would like:  
```
conda create --name py2 python=2.7  
```  
2. Activate the environment:  
```
conda activate py2  
```  
If it is successfully activated you should see the name of the environment in parentheses to the left of your command prompt:  
```  
(py2) user@myComputer$  
```   
3. Since the Docker image uses a .yml and .cwl config files, you need to install `cwl-runner` in python while ensuring the conda environment is active:  
```
pip install cwltool  
pip install cwlref-runner  
```   

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


