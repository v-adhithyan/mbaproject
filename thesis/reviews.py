from selenium import webdriver
import time
import csv
import random

browser = webdriver.Firefox()


urls = [
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Travancore
-reviews-925004518",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Travancore
-reviews-925004518-page-2",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Travancore
-reviews-925004518-page-3",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Patiala
-reviews-925106556",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Patiala
-reviews-925106556-page-2",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Patiala
-reviews-925106556-page-3",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Hyderabad
-reviews-925004478",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Hyderabad
-reviews-925004478-page-2",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Hyderabad
-reviews-925004478-page-3",
"https://www.mouthshut.com/product-reviews/State-Bank-Of-Mysore
-reviews-925004516",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Bikaner
-and-Jaipur-reviews-925754283",
"https://www.mouthshut.com/product-reviews/State-Bank-of-Bikaner
-and-Jaipur-reviews-925754283-page-2"
    ]

fields = ["date", "reviews", "star"]
data = []
for url in urls:
    browser.get(url)

    reviews = browser.find_elements_by_xpath
            ("//div[@class='more reviewdata']")
    dates = browser.find_elements_by_xpath
            ("//p[@class='rating']")
    read_more = browser.find_elements_by_xpath
            ("//a[contains(text(), 'Read More')]")

    #expand all reviews
    for r in read_more:
        r.click()
        time.sleep(random.randint(2, 4))

    i = 0
    for review in reviews:
        try:
            text = review.text
            text = text.encode("ascii", "ignore")
            text = text.replace("...", "")
            text = text.replace("Flag this review", "")
            text = text.lstrip().rstrip().strip()
            date = dates[i].text
            if "AM" in date:
                date = date.split("AM")[0]
            elif "PM" in date:
                date = date.split("PM")[0]

            rating = str(len(dates[i].find_elements_by_class_name
                ('rated-star')))
            print text
            print date
            print rating

            row = {}
            row[fields[0]] = date
            row[fields[1]] = text
            row[fields[2]] = rating
            data.append(row)
        except:
            print "Exception"
        finally:
            print "in finally increment i"
            i = i + 1

    print "Scraped a page.. going to sleep"
    time.sleep(random.randint(10, 15))
    print "Wake from sleep"

browser.quit()

print "writing to file"
with open("reviews.csv", "w") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=fields)
    writer.writeheader()
    writer.writerows(data)
print "Write success .."
