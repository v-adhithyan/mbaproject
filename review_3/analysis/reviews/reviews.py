import urllib2
from bs4 import BeautifulSoup
import time
import csv

review_element = "more reviewdata"
date_element = "date"
star_element = "rating"
next_element = "next"

urls = [
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Travancore-reviews-925004518",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Travancore-reviews-925004518-page-2",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Travancore-reviews-925004518-page-3",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Patiala-reviews-925106556",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Patiala-reviews-925106556-page-2",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Patiala-reviews-925106556-page-3",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Hyderabad-reviews-925004478",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Hyderabad-reviews-925004478-page-2",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Hyderabad-reviews-925004478-page-3",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Mysore-reviews-925004516",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Bikaner-and-Jaipur-reviews-925754283",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Bikaner-and-Jaipur-reviews-925754283-page-2"
        ]

to_csv = []
fields = ["reviews"]
i = 0

for url in urls:
    print "PAGE {}".format(i+1)
    content = urllib2.urlopen(url).read()
    soup = BeautifulSoup(content)

    reviews = soup.find_all("div", {"class": review_element})
    dates = soup.find_all("div", {"class": date_element})
    stars = soup.find_all("div", {"class": star_element})
    next = soup.find_all("li", {"class": next_element})

    #print next.find("a").get("href")
    for review in reviews:
        try:
            r = review.get_text().encode("ascii",  "ignore")
            r = r.replace("...Read More", "")
            #print r
            row = {}
            row[fields[0]] = r
            to_csv.append(row)
        except:
            print "exception"
        finally:


time.sleep(5)

print to_csv
with open("reviews.csv", "w") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=fields)
    writer.writeheader()
    writer.writerows(to_csv)
