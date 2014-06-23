import pandas as pd
import numpy as np
import psycopg2 as psql
import nltk.tokenize as tok
import nltk.corpus as corpus
import nltk.stem as stem
from sklearn.feature_extraction.text import CountVectorizer
import scipy.io as io
import csv
from os.path import isfile

# Get the vocabulary and token count per congress corpus
def token_count_congress(congress,            \
                         limit       = 'ALL', \
                         ngram_range = (2,2), \
                         min_df      = 5,     \
                         store_out   = False, \
                         use_stored  = True):

    file_name_vocab  = '../data/vocab/vocab_'  + str(congress) +'.csv'
    file_name_counts = '../data/counts/counts_'+ str(congress) +'.mtx'

    if isfile(file_name_vocab) and isfile(file_name_counts):
        reader = csv.reader(open(file_name_vocab, 'rb'))
        vocab = dict(x for x in reader)
        counts = io.mmread(file_name_counts).tocsc()
    else:
        conn    = psql.connect("dbname='keyword-influence'")
        cursor  = conn.cursor()

        cursor.execute("SELECT id, speaking FROM words WHERE CAST(congress AS integer) IN (" + str(congress) + ") LIMIT " + str(limit) + ";")

        sql_result = cursor.fetchall()
        counter   = CountVectorizer(stop_words  = corpus.stopwords.words('english'), \
                                    ngram_range = ngram_range, min_df = min_df)

        chunks    = map(lambda x: x[1], sql_result)
        
        counts    = counter.fit_transform(chunks)
        vocab     = counter.get_feature_names()
        vocab     = dict(zip(range(len(vocab)),vocab))

        if store_out:
            writer = csv.writer(open(file_name_vocab, 'wb'))
            for key, value in vocab.items():
                writer.writerow([key, value])
            io.mmwrite(target = file_name_counts, a = counts)

    return [counts, vocab]

# Get the vocabulary and token count for any set of chunk_ids
def token_count_sample(chunk_ids,           \
                       limit       = 'ALL', \
                       ngram_range = (2,2), \
                       min_df      = 5):
    
    conn    = psql.connect("dbname='keyword-influence'")
    cursor  = conn.cursor()

    cursor.execute("SELECT id, speaking FROM words WHERE id IN (" + chunk_ids + ") " \
                    + " LIMIT " + str(limit) + ";")
    sql_result = cursor.fetchall()

    counter   = CountVectorizer(stop_words  = corpus.stopwords.words('english'), \
                                ngram_range = ngram_range,                       \
                                min_df      = min_df)

# Get relative frequencies of each token in a sample
def get_rel_freqs(count_matrix):
    total_count = count_matrix.sum()
    col_sums = np.asarray(count_matrix.sum(2)).flatten()
    word_freqs = 1. * col_sums / total_count
    return(word_freqs)

# Pring top N tokens by frequency 
def print_top_tokens(count_matrix, vocab, n=5):
    rel_freqs   = get_rel_freqs(count_matrix)
    top_indexes = rel_freqs.argsort()[::-1][:n] 
    for i in top_indexes:
        print "%.4f" % str(rel_freqs[i]) + " | " + str(count_matrix[:,i].sum()) + " | " + vocab.get(str(i))

# Calculate frequency discrepancy

# Rank most highly discrepant tokens