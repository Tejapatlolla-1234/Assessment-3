
library("seqinr")
library("R.utils")
library("rBLAST")
library("ape")
library("ORFik")
library("Biostrings")
source("https://raw.githubusercontent.com/markziemann/SLE712_files/master/bioinfo_asst3_part2_files/mutblast_functions.R")

#Question 1 :- a) Download E.coli gene DNA sequence

if ( ! file.exists("Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa") ) {
  download.file("ftp://ftp.ensemblgenomes.org/pub/bacteria/release-42/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/cds/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz",
                destfile = "Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz")
}


# b) decompress the file

R.utils::gunzip("Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz" , overwrite=TRUE)


# c) creating blast database

makeblastdb("Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa" , dbtype= "nucl" ,  "-parse_seqids")

#number of sequences in E.coli set - 4140

#Question 2:- a) downloading sample fasta sequence

download.file("https://raw.githubusercontent.com/markziemann/SLE712_files/master/bioinfo_asst3_part2_files/sample.fa" ,
              destfile = "sample.fa")
SEQ<-read.fasta("sample.fa")
str(SEQ)

# b) Extracting allocated sequence from above sample

mySeq <- SEQ[[73]]
str(mySeq)

# c) length and proportion of GC bases

seqinr::getLength(mySeq)
seqinr::GC(mySeq)

# Question 3 :- a) Use blast to identify best match(BM) of  E.coli gene with my sequence (mySeq)

myblastn_tab(myseq = mySeq , db = "Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa")
BM<-myblastn_tab(myseq = mySeq , db = "Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa")
head(BM)
str(BM)
hits <- as.character(BM[1:3]) 
hits


# Question 4 :-


