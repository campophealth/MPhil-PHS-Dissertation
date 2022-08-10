#!/bin/bash

# command: run ANNOVAR gene-based annotation using build hg38 on topmed imputed data

./annotate_variation.pl -out /input_file -build hg38 /input_file.txt humandb/

# note 1: this generates two file outputs w: input_file.variant_function and input_file.exonic_variant_function. the first file includes gene annotation as well as whether the variant is exonic, splicing, UTR5, UTR3, intronic, intergenic, upstream, downstream or ncRNA. the second file contains the amino acid changes as a result of the exonic variant: possible values are nonsynonymous SNV, synonymous SNV, frameshift insertion, frameshift deletion, nonframeshift insertion, nonframeshift deletion, frameshift block substitution, and nonframeshift block substitution.

# note 2: the below commands outlines code run to filter variants for one specific chromosome, 22. it was replicated using perl for all chromosomes.

# command: create tab separated file of the topmed_annovar_22.exonic_variant_function files

gawk -v FS="\t" '{namef=$2
gsub(/ /, "_", namef)
split($3, a, /:/)
print a[1], namef, $3, $4}' topmed_annovar_22.exonic_variant_function > topmed_annovar_22.exonic.bed

# command: filter by minor allele frequency < 0.001 (noted by column 11), imputation r2 score >= 0.8 (noted by column 12) and remove any unknown genes (noted by column 2) classified as unknown

gawk -F' ' '$11 <= 0.001 && $12 >= 0.8 && $2 != "unknown" {print}' topmed_annovar_22.exonic.bed > filter1_topmed_annovar_22.exonic.bed

# command: find the number of variants by functional consequence (noted by column 3)

cut -f 3 -d ' ' filter1_topmed_annovar_22.exonic.bed | sort | uniq -c | sort -n

# note 3: this yielded output as the following:
# 4 stoploss
# 8 nonframeshift_substitution
# 128 frameshift_substitution
# 217 stopgain
# 2776 synonymous_SNV
# 3333 nonsynonymous_SNV

# command: filter by functional consequence! remove synonymous variants. separate nonsense/frameshift, missense and all nonsynonymous into three sets of data

gawk -F' ' '$3 != "synonymous_SNV"' filter1_topmed_annovar_22.exonic.bed  /nonsyn/topmed_annovar_22.nonsyn.bed

gawk -F' ' '$3 == "stopgain" && $3 == "stoploss" && $3 == "frameshift_substitution" {print}' /nonsyn/topmed_annovar_22.nonsyn.bed > /home/fsn/topmed_annovar_22.fsn.bed


gawk -F' ' '$3 == "nonsynonymous_SNV" {print}' /nonsyn/topmed_annovar_22.nonsyn.bed > /home/mis/topmed_annovar_22.mis.bed

# command: create summary files for RAML and CMAT analysis with variant and gene as headers

gawk 'BEGIN {print "Variant\tGene"}1 {print $1, $2}' topmed_annovar_22.nonsyn.bed > summary_nonsyn_topmed_onco_chr22.txt

gawk 'BEGIN {print "Variant\tGene"}1 {print $1, $2}' topmed_annovar_22.fsn.bed > summary_fsn_topmed_onco_chr22.txt

gawk 'BEGIN {print "Variant\tGene"}1 {print $1, $2}' topmed_annovar_22.mis.bed > summary_mis_topmed_onco_chr22.txt