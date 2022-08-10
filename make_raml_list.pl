#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use YAML;
use diagnostics;

my $scratch = "/filepath1";
my $bin = "~/filepath2";
my $store_gwas = "/filepath3";
my $topmed     = "/filepath4";
my $summary = "/filepath5";

# each chromosome file was split in separate chunks to be manageable files. the chromosomal position has been altered, and the number of chunks has been randomized to keep data confidential. only chromsomes 1 and 22 are seen here, but all chromosomes were included in the below pipe,

my %chr_range = ("1_p1" => "10555-46000000", "1_p2" => "46000001-80000000", "1_p3" => "80000000-150000000",
                 "22" => "10500000-49999888",);

my %a_mina = ("0.8" => [0.2],); # can be changed to add multiple values

foreach my $file ( sort(keys(%chr_range)) ) {
foreach my $a_val ( sort(keys(%a_mina))){
foreach my $min_a_val ( @{$a_mina{$a_val}} ) {
            my $file_without_part = $file =~ s/_p[0-9]//gr;
            my @cmd_list = ("${bin}/raml_test",
                            "-i ${store_gwas}/topmed_onco_${file}.bgen",
                            "-p ${topmed}/oncoarray_topmed_phenotypes.txt", # set to string
                            "-n 100",
                            "-m 0.001",
                            "-g all_non_mucinous",
                            "--minalpha $min_a_val", # experiment
                            "-a $a_val", # experiment
                            "-l 0.001",
                            "-u 4",
                            "-t 0.1",
                            "--range chr${file_without_part}:$chr_range{$file}",  # set range
                            "-o m_raml_chr${file}_${a_val}_${min_a_val}.txt", # set values
                            "-s ${summary}/m_summary_topmed_onco_chr${file_without_part}.txt"); # set to string
            my $cmd = join(" ", @cmd_list);
            print "$cmd\n"
        }
}
}
