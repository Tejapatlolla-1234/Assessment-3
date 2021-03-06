
library("seqinr")
library("R.utils")
library("rBLAST")
library("ape")
library("ORFik")
library("Biostrings")
source("https://raw.githubusercontent.com/markziemann/SLE712_files/master/bioinfo_asst3_part2_files/mutblast_functions.R")

#Question 1 :- a) Downloading E.coli gene DNA sequence

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

# Question 3 :-  Use blast to identify best match(BM) of  E.coli gene with my sequence (mySeq)

myblastn_tab(myseq = mySeq , db = "Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa")
BM<-myblastn_tab(myseq = mySeq , db = "Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa")
head(BM)
str(BM)
hits <- as.character(BM$sseqid[1:3]) 
hits

# Question 4 :-  To check the number of mismatches between the original and mutated sequence

mutator(mySeq,50)
mySeq_mut <- mutator(mySeq,50)
myblastn_tab(mySeq_mut , db="Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa")

# Question 5 :- 

Result <- function(mySeq, nmut) {
  mutSeq <- mutator(myseq = mySeq, nmut = nmut)
  res <- myblastn_tab(myseq = mutSeq, db="Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa")
if ( is.null(res) ) { 
  myres=0 } else { myres=1 
  }
return(myres)
}
replicate(n=100, expr = Result(mySeq,100) )
mean(replicate(n=100, expr = Result(mySeq,100) ))
str(mean)
finalres <- function (n){
  mean(replicate(n , expr = Result(mySeq,100) ) )
}
n <- c(10,50,100,150,200,250,300,350,400)
END<-sapply(n, finalres)
END


# Question 6 

plot(n , END , xlab = "number of sites", ylab = "proportion of mutated bases", 
     main = " How the increasing proportion of mutated bases reduces the ability for BLAST" , type = "o", col = "orange")


