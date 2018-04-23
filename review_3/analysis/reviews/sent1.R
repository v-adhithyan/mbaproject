library(tidyverse)      # data manipulation & plotting
library(stringr)  
library(tidytext)
library(harrypotter)    # provides the first seven novels of the Harry Potter series
library(dplyr)
data <- read.csv("reviews.csv")
reviews <- as.vector(data['reviews'])

tokens <- data_frame(text= reviews) %>% unnest_tokens(word, text)
#tokens <- data.table::data.table(tokens)
tokens %>% 
 inner_join(get_sentiments("nrc")) %>% 
  filter(!is.na(sentiment)) %>% filter(sentiment == "happy") 
tokens