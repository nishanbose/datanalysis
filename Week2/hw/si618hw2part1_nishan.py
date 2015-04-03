#!/usr/bin/env python
# -*- coding: utf-8 -*-

#yelp academic dataset
#https://drive.google.com/file/d/0BxlZefq_RVoNTzZPMVVfak40WDg/view?usp=sharing

__author__ = 'nishan'

import json
import csv

data = []

IN = open('yelp_academic_dataset.json', 'rU')

with IN as f:
    for line in f:
        data.append(json.loads(line))

IN.close()

filtered_list = []

for item in data:
    if item['type'] == 'business':
        name = item['name']
        city = item['city']
        state = item['state']
        stars = item['stars']
        counts = item['review_count']
        if len(item['categories']) == 0:
            category = 'NA'
        else:
            category = item['categories'][0]
        filtered_list.append((name, city, state, stars, counts, category))

OUT = open("businessdata.tsv", "wb")

with OUT as yelp_tsv:
    _file = csv.writer(yelp_tsv, delimiter="\t")
    _file.writerow(["name", "city", "state", "stars", "review_count", "main_category"])
    for item in filtered_list:
        _file.writerow([unicode(val).encode("utf-8") for val in item])

OUT.close()
