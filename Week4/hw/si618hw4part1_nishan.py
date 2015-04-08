#!/usr/bin/env python
# -*- coding: utf-8 -*-

#yelp academic dataset
#https://drive.google.com/file/d/0BxlZefq_RVoNTzZPMVVfak40WDg/view?usp=sharing

__author__ = 'nishan'

import json
import nltk
import re

regex = re.compile(r"\b[\w']+\b")

stemmer = nltk.PorterStemmer()

word_sentiment = {}

stem_dict = open('sentiment_word_list_stemmed.json', 'rU')

for line in stem_dict:
    sentiment = json.loads(line)

stem_dict.close()

def st_rv(sr):
    srs = []
    for word in sr:
        srs.append(stemmer.stem(word))
    return srs

def calsent(sr):
    score = 0
    for word in sr:
        if word in sentiment:
            score += sentiment[word]
    return score

frs = dict()
frst = dict()

IN = open('yelp_academic_dataset.json', 'rU')

with IN as f:
    for line in f:
        proc = json.loads(line.strip())
        if proc['type'] == 'review':            
            sr = list(regex.findall(proc["text"].strip()))
            srs = st_rv(sr)
            ss = calsent(srs)

            bid = proc['business_id']

            if not bid in frs:
                frs[bid] = []
                frs[bid].append(proc['stars'])
            else:                
                frs[bid].append(proc['stars'])

            if not bid in frst:
                frst[bid] = []
                frst[bid].append(ss)
            else:
                frst[bid].append(ss)

IN.close()

OUT = open('star_sentimentscore.txt', 'w+')

with OUT as result:
    for item in frs.keys():
        avgstars = float(sum(frs[item])) / len(frs[item])
        avgsentiment = float(sum(frst[item])) / len(frst[item])
        result.write(str(avgstars) + "\t" + str(avgsentiment) + "\n")

OUT.close()