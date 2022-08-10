# MPhil-PHS-Dissertation

The repository contains all the code used for my Masters of Philosophy dissertation. The dataset contains genotyping data from 63 projects participating in the Ovarian Cancer Association Consortium (OCAC) and can be found at the European Genome-phenome Archive (https://ega-archive.org/). The summary results of the OCAC germline genotype data can be found at http://ocac.ccge.medschl.cam.ac.uk/.

The code published in this repo includes samples of the R code used for making graphs, perl code for running the RAML and CMAT analyses, and additional bash scripts used for annotation and filtering. 

## Power curves

Annotated code used to make power curves can be found in the p_curves_t.R and p_curves_s.R files. In file p_curves_t.R, power curves were created for a theoretical sample of 50,000 (13,500 cases and 35,000 controls) to demonstrate the increase in power of detecting rare genetic variation with burden testing (Figure 1). Power curves were also created for the actual sample of 23,564 cases and 40,138 controls (Figure 5). 

## Annotation and filtering

Annotation was run using the variant annotation tool ANNOVAR by Joe Dennis. Variant filtering was done using basic gawk commands on Linux, and was run by myself. A sample of the code used can be found in the bash script anno_filter.sh, which outlines how annotation was run as well as variant filtering steps for chromosome 22. 

## RAML and CMAT analyses

Both the RAML and CMAT analyses were run using the RAML program, developed by Dr Jonathan P Tyrer, Dr Qi Guo and Dr Douglas Easton. In the bash script raml_cmat.sh, an example of the command and a description of the flags used are outlined. Additionally, commands used to identify the top significant genes are also highlighted. A sample of the perl script written to automate the list of RAML commands for all chromosomes is also available in the file make_raml_list.pl. The script was written by myself, with the assistance of Dr. Michael Lush. More on the RAML method can be found here: https://doi.org/10.1186/1471-2105-14-177. Further details on the CMAT can be found here: https://doi.org/10.1016/j.ajhg.2010.10.012.

## Q-Q plots

Quantile-quantile (Q-Q) plots were created to investigate whether the test statistics are inflated. A genomic inflation factor, $\lambda$, was calculated by converting the *P*-values into the equivalent  $χ^2$  statistic from the $χ^2$ distribution on one degree of freedom. $\lambda$ was given by the median of the observed $χ^2$ statistics divided by the expected median of the $χ^2$ distribution. 

The Q-Q plots were created for *P*-values from CMAT and RAML analyses on four subsets of the data: all coding variants, all nonsynonymous variants, all missense variants, and frameshift and nonsense variants. The Q-Q plots created from CMAT analyses (Figure 4) can be found in the file CMAT_pvals.R, and the Q-Q plots created from RAML analyses (Figure 3) can be found in the file RAML_pvals.R.

