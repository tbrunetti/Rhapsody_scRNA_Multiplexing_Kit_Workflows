#!/bin/bash

# comment out if not using conda to access python2.7 environment
conda activate py2

# command to run docker image -- be sure the version for .cwl and .yml match
# make sure the .yml file is updated -- DO NOT modify the .cwl file!
# if you only have a single core remove the --parallel flag
sudo cwl-runner --parallel rhapsody_wta_1.10.cwl template_wta_1.10.yml
