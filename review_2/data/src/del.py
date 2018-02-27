import csv

list = []
with open("tweets.csv", "r") as f:
    reader = csv.DictReader(f)

    for row in reader:
        tweet = row['tweet']
        if not "@TheOfficialSBI" in row:
            print row
            
            json = {}
            json['tweet']  = row
            list.append(json)

with open("tweets.csv", "w") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=["tweet"])
    writer.writeheader()
    writer.writerows(list)