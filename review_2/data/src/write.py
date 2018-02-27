import tweepy
import os
import csv

"""
consumer_key = os.environ["TW_CONSUMER_KEY"]
consumer_secret = os.environ["TW_CONSUMER_DATA"]

access_token = os.environ["TW_ACCESS_TOKEN"]
access_token_secret = os.environ["TW_ACCESS_SECRET"]

"""

consumer_key = "Z6seXpneUms6kXNNnFE6ab9EE"
consumer_secret = "ubxTYvelvkSFJrBOmE4x9SGdEKtesJjuw65ByTEPFdbup7svZu"

access_token = "946191048560189441-BpRlClphImWdkhd96I7TuKnSzDTujBh"
access_token_secret = "EOdfWPwVKNQ6A0LL3l33Kgo1KrXn2WWtKUua6YI30Gfg1"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)


hashtag = raw_input("new  enter hashtag:")
tweets = tweepy.Cursor(api.search, q='{}'.format(hashtag), lang="en").items()

list = []
json = {}
for tweet in tweets:
    try:
        text = u''.join(tweet.text).encode("utf-8").strip()
    # include tweets only from other prople, ignore sbi tweets
        if not "@TheOfficialSBI" in text:
            json = {}
            json['tweet'] = text
            list.append(json)
            print text
    except:
        pass
#print list

with open("tweets.csv", "w") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=["tweet"])
    writer.writeheader()
    writer.writerows(list)

