# MPhil-PHS-Dissertation

The repository contains all the code used for my Masters of Philosophy dissertation. The dataset contains genotyping data from 63 projects participating in the Ovarian Cancer Association Consortium (OCAC) and can be found at the European Genome-phenome Archive (https://ega-archive.org/). The summary results of the OCAC germline genotype data can be found http://ocac.ccge.medschl.cam.ac.uk/.

The code published in this repo includes samples of the R code used for making graphs, perl code for running the RAML and CMAT analyses, and additional bash scripts used for annotation and filtering.

## Power curves

Annotated code used to make power curves can be found in the p_curves_t.R and p_curves_s.R files. In file p_curves_t.R, power curves were created for a theoretical sample of 50,000 (13,500 cases and 35,000 controls) to demonstrate the increase in power of detecting rare genetic variation with burden testing. Power curves were also created for the actual sample of 23,564 cases and 40,138 controls. 

## RAML and CMAT analyses



## Annotation and filtering

## Q-Q plots

Quantile-quantile (Q-Q) plots were created to investigate whether the test statistics are inflated. A genomic inflation factor, λ, was calculated by converting the P^values into the equivalent χ^2 statistic from the $χ^2$ distribution on one degree of freedom. λ was given by the median of the observed χ^2 statistics divided by the expected median of the χ^2 distribution.

##
