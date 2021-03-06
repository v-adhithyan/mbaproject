# load necessary packages
if (require(tm) == FALSE) {
  install.packages("tm")
  library(tm)
}
if (require(stringr) == FALSE) {
  install.packages("stringr")
  library(stringr)
}

# convert a specified column in csv file to a vector
vectorConvertor <- function(filename, textColNumber, whetherHeader = TRUE) {
  data <- read.csv(filename, whetherHeader)
  data <- data[,textColNumber]
  data <- as.vector(data)
}

# convert text vector to a term-Document Matrix
# input: text vector
# output: PlainTextDocument
plainTextDocumentConverter <- function(data) {
  # remove non utf-8 characters
  data <- str_replace_all(data,"[^[:graph:]]", " ")
  # convert data to corpus
  data <- Corpus(VectorSource(data))
  # lowercase
  data <- tm_map(data, tolower)
  # remove punctuation
  data <- tm_map(data, removePunctuation)
  # remove stop words
  data <- tm_map(data, function(x) removeWords(x, stopwords()))
  # make sure the data is PlainTextDocument 
  data <- tm_map(data, PlainTextDocument)
  return(data)
}

# convert text vector to data frame that can be used directly for text analysis
# input: text vector, sparsity degree, termAsRow
# output: data frame
dataFrameConverter <- function(data, sparse = 0.92, termAsRow = TRUE) {
  # convert text vector into PlainTextDocument
  data.tm <- plainTextDocumentConverter(data)
  data.tm <- TermDocumentMatrix(data.tm)
  # Remove sparse terms
  data.trial <-removeSparseTerms(data.tm, sparse)
  # make the names of each doc different: from 1 to length(data)
  data.trial$dimnames$Docs <- seq(1:length(data))
  # change the type of names from numeric to character
  # otherwise the conversion from term-doc matrix to matrix will fail
  data.trial$dimnames$Docs <- as.character(data.trial$dimnames$Docs)
  # convert term-doc matrix to matrix
  data.m <- as.matrix(data.trial)
  # if termAsRow is false, flip the matrix
  if (termAsRow == FALSE) {
    data.m <- t(data.m)
  }
  # convert matrix to data frame
  data.fm <- as.data.frame(data.m)
  
  return(data.fm)
}

hclusterofwords <- function(data.fm) {
  # scale the data frame
  data.fm <- scale(data.fm)
  # h-cluster
  data.cluster <- hclust(dist(data.fm, method = "euclidean"), method = "ward.D2")
  # plot h-cluster
  plot(data.cluster)
  return (data.cluster)
}

### cluster function
tryCluster <- function(filename, textColNumber, termAsRow = TRUE, sparse = 0.92, whetherHeader = TRUE) {
  data <- vectorConvertor(filename, textColNumber, whetherHeader = TRUE)
  data.fm <- dataFrameConverter(data, 0.92, FALSE)
  hclusterofwords(data.fm)
}