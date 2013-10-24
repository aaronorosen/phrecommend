import sys, re
from boilerpipe.extract import Extractor

fileText = ''
with open(sys.argv[1], 'r') as file:
  fileText = file.read()

extractor = Extractor(extractor='ArticleExtractor', html=fileText)
text = extractor.getText().encode('utf-8').lower()
pattern = re.compile('[^0-9a-z\s\.]+')
tokens = pattern.sub(' ', text).split()
ngrams = {}

maxLength = int(sys.argv[2])
wordCount = len(tokens)
for index in range(0, wordCount):
  if len(tokens[index]) > 0:
    gram = tokens[index]
    #Add unigram to ngrams dictionary
    if gram in ngrams:
      ngrams[gram] += 1
    else: ngrams[gram] = 1

    #Generate contiguous ngrams
    for i in range(1, maxLength):
      if index + i < wordCount: gram += ' ' + tokens[index + i]
      #Add ngram to dictionary
      if gram in ngrams:
        ngrams[gram] += 1
      else:
        ngrams[gram] = 1

print 'Generated ' + str(len(ngrams)) + ' ngrams.'
output = ''.join(['%s\t%s\n' % (key, value) for (key, value) in ngrams.items()])
with open('output.txt', 'w') as file:
  file.write(output)
