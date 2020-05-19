
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

#Question 6 :- a)downloading growth_data.csv into R script

download.file("https://raw.githubusercontent.com/markziemann/SLE712_files/master/bioinfo_asst3_part1_files/growth_data.csv" ,
              destfile = "growth_data.csv")

# b)read table treesgrowth (TG) into R script

TG<- read.csv("growth_data.csv", sep = "," , header = TRUE,  stringsAsFactors = FALSE )
head (TG)
str(TG)

# c)specifying column names of data treesgrowth

colnames(TG)


#Question 7 :- Mean and standard deviation calculation of tree circumference (circumf) at start and end of the study both sites

# subset of northeast (NE) Site in trees growth

subset(TG , site == "northeast")
subset(TG , Site == "northeast")
NE<-subset(TG , Site == "northeast")
head(NE)
str(NE)

#mean and standard deviation calculation of  circumf at start of NE Site

mean(NE$Circumf_2004_cm)
sd(NE$Circumf_2004_cm)

#mean and standard deviation calculation of  circumf at end of NE Site

mean(NE$Circumf_2019_cm)
sd(NE$Circumf_2019_cm)


# subset of sowthwest (SW) Site in trees growth

subset(TG , Site == "southwest")
SW<-subset(TG , Site == "southwest")
head(SW)
str(SW)

#mean and standard deviation calculation of  circumf at start of SW Site

mean(SW$Circumf_2004_cm)
sd(SW$Circumf_2004_cm)

#mean and standard deviation calculation of  circumf at end of SW Site

mean(SW$Circumf_2019_cm)
sd(SW$Circumf_2019_cm)

#Question 8 :- boxplot of tree circumference at start and end of the study at both sites

# boxplot at the start and end of NE site

boxplot(NE$Circumf_2004_cm , NE$Circumf_2019_cm, main = "Box plot of tree circumference at start and end of northeast site",
        ylab = "Circumference")

