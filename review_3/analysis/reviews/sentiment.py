import pandas as pd
import numpy as np
from IPython.display import display
import matplotlib.pyplot as  plt
import seaborn as sns
import csv
import re
from textblob import TextBlob

def clean(review):
    '''
    Utility function to clean the text in a tweet by removing 
    links and special characters using regex.
    '''
    return ' '.join(re.sub("(@[A-Za-z0-9]+)|([^0-9A-Za-z \t])|(\w+:\/\/\S+)", " ", review).split())

def analize_sentiment(review):
    '''
    Utility function to classify the polarity of a tweet
    using textblob.
    '''
    analysis = TextBlob(clean(review))
    if analysis.sentiment.polarity > 0:
        return 1
    elif analysis.sentiment.polarity == 0:
        return 0
    else:
        return -1
        
df = pd.read_csv("reviews1.csv")
reviews = df.reviews
ratings = df.star
date = df.date
response = df.response

data = pd.DataFrame(data=reviews, columns = ["reviews"])
data["reviews"] = reviews
data["ratings"] = ratings
data["date"] = date
data["response"] = response
data['SA'] = np.array([analize_sentiment(review) for review in data["reviews"]])
display(data.head(10))

tratings = pd.Series(data=data["ratings"].values, index=data["date"])
tresponse = pd.Series(data=data["response"].values, index=data["date"])

tratings.plot(figsize=(16,4), label = "Ratings", legend = True)
tresponse.plot(figsize=(16,4), label = "Response", legend = True)

plt.show()

pos_reviews = [ review for index, review in enumerate(data['reviews']) if data['SA'][index] > 0]
neu_reviews = [ review for index, review in enumerate(data['reviews']) if data['SA'][index] == 0]
neg_reviews = [ review for index, review in enumerate(data['reviews']) if data['SA'][index] < 0]

print("Percentage of positive tweets: {}%".format(len(pos_reviews)*100/len(data['reviews'])))
print("Percentage of neutral tweets: {}%".format(len(neu_reviews)*100/len(data['reviews'])))
print("Percentage de negative tweets: {}%".format(len(neg_reviews)*100/len(data['reviews'])))
