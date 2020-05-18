
#Question 1 :-  a) Downloading date in the file "gene_expression.tsv"

download.file("https://raw.githubusercontent.com/markziemann/SLE712_files/master/bioinfo_asst3_part1_files/gene_expression.tsv",
              destfile = "gene_expression.tsv")

# b) read into R script , making sure gene accession numbers as the row names and headers are recognised

GE<- read.table("gene_expression.tsv", header = TRUE, row.names = 1 , stringsAsFactors = FALSE )
head(GE)
str(GE)

#Question 2 :- making new column which is mean of other columns
GE$mean<-rowMeans(GE)
head(GE)
str(GE)

#Question 3 :- list of 10 genes with highest mean expression in order

order(GE$mean)
order(-GE$mean)
ord<-GE[order(-GE$mean),]
head(ord,10)

#Question 4 :- subset of genes with mean less than 10

subset(GE , mean<10)

#Question 5 :- histogram of mean values

hist(GE$mean)
hist(GE$mean , main="Histogram plot of the mean values" , xlab = "Mean values" , border = "blue" , col = "orange")
