
library("seqinr")
library("R.utils")
library("rBLAST")
library("ape")
library("ORFik")
library("Biostrings")

#Question 1 :- a) Download E.coli gene DNA sequence

if ( ! file.exists("Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa") ) {
  download.file("ftp://ftp.ensemblgenomes.org/pub/bacteria/release-42/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/cds/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz",
                destfile = "Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz")
}


# b) decompress the file

R.utils::gunzip("Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz" , overwrite=TRUE)


# c) creating blast database

makeblastdb("Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa" , dbtype="nucl" ,  "-parse_seqids")

E.coli<-read.fasta("Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa") 
str(E.coli)

#number of sequences in E.coli set
seqinr::getLength(E.coli)

