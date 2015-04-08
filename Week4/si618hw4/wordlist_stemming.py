# Demo usage of PorterStemmer() in NLTK
# Written by Yuhang Wang

import nltk, json

stemmer = nltk.PorterStemmer()
word_sentiment = {}

sentimentfile = open('sentiment_word_list.txt', 'rU')
for line in sentimentfile:
  line = line.strip()
  word, sentiment = line.split(',')
  sentiment = int(sentiment)
  word = stemmer.stem(word)
  word_sentiment[word] = sentiment

sentimentfile.close()

stemmedfile = open('sentiment_word_list_stemmed.json', 'w')
json.dump(word_sentiment, stemmedfile)
stemmedfile.close()
