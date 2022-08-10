#!/bin/bash

# command: to create the list of commands, the following command was used:

perl make_raml_list.pl > raml_list_todo.sh 

# command: to run all commands, run_list was used

run_list raml_list_todo.sh 

# note: below, a sample of the command generated, which run association analyses for a subset of identified missense variants in chr22

~/raml -i /topmed_onco_22.bgen -p /phenotypes.txt -n 100 -m 0.001 -g all_non_mucinous --minalpha 0.2 -a 0.8 -l 0.001 -u 4 -t 0.1 --range chr22:10500000-49999888 -o mis_raml_chr22_0.8_0.2.txt -s /summary_mis_topmed_onco_chr22.txt

# note: some of the flags are expanded below:
# -i: data file with imputed data
# -p: phenotype file
# -n: minimum number of permutations
# -m: maximum MAF to consider
# -g: phenotype to analyse
# --minalpha: minimum proportion of associated variants 
# -a: maximum proportion of associated variants 
# -l: lower bound of variance parameter 
# -u: upper bound of variance parameter
# -t: minimum dosage to consider variant non-zero 
# --range: chromosomal range for analysis
# -o: results output 
# -s: summary file to use, i.e., list of filtered variants

# command: to find the top significant genes among all missense variants, the output file was sorted by p-value (RAML, p-value noted by column 14, or CMAT p-value noted by column 17)

gawk 'NR==1 || FNR!=1{print (NR==1?"Filename":FILENAME),$0}' mis_raml_chr* | sort -k15g | cut -f1-17 | head -20

# command: to find values by a specific gene, the following command was run:

gawk 'NR==1 || FNR!=1{print (NR==1?"Filename":FILENAME),$0}' mis_raml_chr* | awk '$2 == "PMS2"'