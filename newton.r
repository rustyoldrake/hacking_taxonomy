######################################################
### Experimental Code.  Playing with this http://www.alchemyapi.com/products/alchemylanguage/taxonomy and 
### this https://github.com/bmschmidt/wordVectors 
######################################################

library(RCurl) # General Network Client Interface for R
library(rjson) # JSON for R
library(jsonlite) # JSON parser
library(XML) # XML parser
library(httr) # Tools for URLs and HTTP
library(stringr)
library(data.table) # data shaping
library(reshape2) # data shaping
library(tidyr) # data cleaning
library(dplyr) # data cleaning
library(png) # for the presenting of images

## This next line sets CERT Global to make a CA Cert go away - http://stackoverflow.com/questions/15347233/ssl-certificate-failed-for-twitter-in-r
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
Sys.setlocale(locale="C") # error: input string 1 is invalid in this locale

######### Housekeeping And Authentication 
setwd("/Users/ryan/Documents/Project_Gravity_Well")
getwd()

library(wordVectors)

# test
subjects = demo_vectors[[c("history","literature","biology","math","stats"),average=FALSE]]
cosineSimilarity(subjects,subjects)

#
IAB_level1 <- read.csv("IAB_Level1.csv",header=FALSE)


list <- c("history","literature","biology","math","stats")
subjects = demo_vectors[[(list),average=FALSE]]
cosineSimilarity(subjects,subjects)


list <- paste(IAB_level1$V1)
subjects = demo_vectors[[(list),average=FALSE]]
cosineSimilarity(subjects,subjects)

## This is terrific! https://github.com/bmschmidt/wordVectors
## Just follow directions - An R package for creating and exploring word2vec and other word embedding models
## Takes a while to TRAIN a real model. 
## install_github("bmschmidt/wordVectors") - 10minutes ish


IAB_level1$V1<- paste(IAB_level1$V1)
len <- length(IAB_level1$V1)
for(i in 1:len){
  print(IAB_level1$V1[i])
  print(nearest_to(model,model[[paste(IAB_level1$V1[i])]])[2])
}
IAB_level1[1,i]

IAB_level1$V1<- paste(IAB_level1$V1)

list <- paste(IAB_level1$V1)
subjects = model[[list,average=FALSE]]
cosineSimilarity(subjects,subjects)

# model hates the "art and entertainment" format - two words and spaces. so broke them out

IAB_level1b <- read.csv("IAB_Level1b.csv",header=FALSE)
list <- paste(IAB_level1b$V1)
subjects = model[[list,average=FALSE]]

output <- cosineSimilarity(subjects,subjects)
head(output)

# Looks like this 
# food    family        style         home     health       drink        art    fashion    business        law     garden
# food   1.00000000 0.3469642  0.040615528  0.315551801 0.42123524  0.34019750 0.37555496 0.09942916  0.14482110 0.27696142 0.21468574
# family 0.34696424 1.0000000  0.225467316  0.398364171 0.25496032  0.17298373 0.35734465 0.33128786  0.46305366 0.21661741 0.56220337
# style  0.04061553 0.2254673  1.000000000 -0.004419586 0.01738135 -0.07818769 0.03327603 0.40661639 -0.03030328 0.02733659 0.01121951


write.csv(output,"IAB_matrix_out.csv")
