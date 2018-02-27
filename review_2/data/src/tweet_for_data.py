import tweepy
import os

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


hashtag = raw_input("enter hashtag:")
tweets = tweepy.Cursor(api.search, q='{}'.format(hashtag)).items()



reply = "@{}, Hai I am doing a survey on satisfaction of sbi bank customers for my college project. Please fill the survey. No confidential details are asked. It will take only 2 minutes to fill it. https://goo.gl/forms/1QreWBfDw6sPYI0n2"

count = 0
for tweet in tweets:
    try:

        user_name = ""
        tweet_id = tweet.id

        text = u''.join(tweet.text).encode("utf-8").strip()

        if "#review" in str(text).lower():
            #user_name = tweet.user.screen_name
            print "mouth shut, extracting user name"
            tweet_id = tweet.id

            split_text = str(text).split(" ")
            user_name = split_text[-2]

        else :
            user_name = tweet.user.screen_name

        print text
        print user_name
        send = raw_input("Do you want to send a request: y/n:")

        if send.lower() == "y":

            api.update_status(reply.format(user_name), in_reply_to_status = True, in_reply_to_status_id=tweet_id)
            count = count + 1

        if send.lower() == "e":
            break
    except:
        raise
        pass

with open("send.txt", "a") as f:
    f.write("{} tweets sent\n".format(count))