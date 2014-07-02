import pandas        as pd
import numpy         as np
import psycopg2      as psql
import nltk.tokenize as tok
import nltk.corpus   as corpus
import nltk.stem     as stem
import scipy.io      as io
import csv
import pickle
from   sklearn.feature_extraction.text import CountVectorizer
from   os.path import isfile

parlimentary_stop_words = ["mr","madam","speaker","president","chairman","chair","member","members"\
                            "senate","senator","congress","congressman","representatives","colleagues",\
                            "gentleman","majority","minority","ranking",\
                            "united","states","unanimous","consent","rise","balance","would",\
                            "yield","floor","objection","order",\
                            "quorum","honor","recognize","thank"]

# Get the vocabulary and token count per congress corpus
def token_count_congress(congress,            \
                         limit       = 'ALL', \
                         ngram_range = (2,2), \
                         min_df      = 10,     \
                         store_out   = False, \
                         use_stored  = True,
                         stop_words  = parlimentary_stop_words):

    pickle_file_name  = '../data/token_count_congress_' + \
                        str(congress) + '_' +\
                        "_".join([str(ngram_range[0]),\
                                    str(ngram_range[1])]) + \
                        '.p'

    if isfile(pickle_file_name) and use_stored:
        results = pickle.load( open( pickle_file_name, "rb" ) )

    else:
        conn    = psql.connect("dbname='keyword-influence'")
        cursor  = conn.cursor()

        cursor.execute("SELECT id, speaking            \
                        FROM words                     \
                        WHERE CAST(congress AS integer)\
                        IN (" + str(congress) + ")     \
                        LIMIT " + str(limit) + ";")

        sql_result = cursor.fetchall()
        counter   = CountVectorizer(stop_words  = corpus.stopwords.words('english') + stop_words, \
                                    ngram_range = ngram_range, min_df = min_df)

        chunks    = map(lambda x: x[1], sql_result)
        chunk_ids = map(lambda x: x[0], sql_result)
        
        counts    = counter.fit_transform(chunks)
        vocab     = counter.get_feature_names()
        vocab     = dict(zip(range(len(vocab)),vocab))

        results = {'counts': counts, 'vocab': vocab, 'chunk_ids': chunk_ids}

        if store_out:
            pickle.dump( results, open( pickle_file_name, "wb" ) )



    return results

# Get the vocabulary and token count for words spoken by recipients of a pac 
def token_count_pac(pac_id,           \
                    limit       = 'ALL', \
                    ngram_range = (2,2), \
                    min_df      = 5):
    
    conn    = psql.connect("dbname='keyword-influence'")
    cursor  = conn.cursor()

    cursor.execute("SELECT id, speaking                       \
                    FROM words                                \
                    WHERE id IN (                             \
                        SELECT id                             \
                        FROM words                            \
                        WHERE bioguide_id IN(                 \
                            SELECT bioguide_id                \
                            FROM pac_contrib as pc            \
                            INNER JOIN congress as c          \
                            ON pc.fec_candidate_id = c.fec_id \
                            WHERE pac_id = '"+ pac_id +"'));")
    sql_result = cursor.fetchall()

    counter   = CountVectorizer(stop_words  = corpus.stopwords.words('english'), \
                                ngram_range = ngram_range,                       \
                                min_df      = min_df)
    chunks    = map(lambda x: x[1], sql_result)
    counts    = counter.fit_transform(chunks)
    vocab     = counter.get_feature_names()
    vocab     = dict(zip(range(len(vocab)),vocab))
    
    return [counts, vocab]

def get_chunk_ids_by_pac(pac_id):
    
    conn    = psql.connect("dbname='keyword-influence'")
    cursor  = conn.cursor()
    
    cursor.execute("SELECT id FROM words        \
                        WHERE bioguide_id IN(   \
                            SELECT bioguide_id  \
                            FROM pac_contrib    \
                            INNER JOIN congress \
                            ON pac_contrib.fec_candidate_id = \
                                congress.fec_id \
                            WHERE pac_id = '" + pac_id + "');")
    sql_result = cursor.fetchall()
    chunk_ids = map(lambda x: x[0], sql_result)
    return(chunk_ids)

def compare_freq_pac(pac_id, congress_tokens, smooth_constants = [10,10]):
    '''
    pac_id:          The PAC identifier used to subset speech by 
                     recipients of contributions from that PAC
    congress_tokens: A dictionary containing 'counts', 'vocab' and 'chunk_ids'
                     as returned by token_count_congress()
    '''
    
    # identify the chunks by recipients of the pac
    chunk_ids     = get_chunk_ids_by_pac(pac_id)
    ind_dict      = dict((k,i) for i,k in enumerate(congress_tokens['chunk_ids']))
    inter         = set( ind_dict.keys() ).intersection(chunk_ids)
    indices       = [ ind_dict[x] for x in inter ]
    counts_pac    = congress_tokens['counts'][indices,:]
    
    # compare global and sample frequencies
    global_counts = get_counts(congress_tokens['counts'])
    global_sum    = global_counts.sum()
    global_freqs  = get_rel_freqs(congress_tokens['counts'])
  
    sample_counts = get_counts(counts_pac)
    sample_sum    = sample_counts.sum()
    sample_freqs  = get_rel_freqs(counts_pac)

    size_ratio    = float(sample_sum) / float(global_sum)
    print global_sum, sample_sum, size_ratio
    freq_diff     = sample_freqs - global_freqs
    vocab_diffs   = zip(congress_tokens['vocab'].values(), freq_diff)
    
    result = pd.DataFrame(vocab_diffs, columns=['ngram','freq_diff'] )
    result['sample_n']      = sample_counts
    result['global_n']      = global_counts
    result['sample_freq']   = sample_freqs
    result['global_freq']   = global_freqs
    result['freq_ratio']    = result.apply(lambda row: (row['sample_freq']) / (row['global_freq']), axis=1)
    result['fratio_smooth'] = result.apply(lambda row: ((1.*row['sample_n'] + smooth_constants[0]) / \
                                                        (1.*row['global_n'] + smooth_constants[1]))/ \
                                                          size_ratio, axis=1)

    print result.sort('fratio_smooth')
    
    return(result)

# Get relative frequencies of each token in a sample
def get_counts(count_matrix):
    return np.asarray(count_matrix.sum(2)).flatten()

def get_rel_freqs(count_matrix):
    total_count  = count_matrix.sum()
    ngram_counts = get_counts(count_matrix)
    word_freqs   = 1. * ngram_counts / total_count
    return word_freqs

# Pring top N tokens by frequency 
def print_top_tokens(count_matrix, vocab, n=5):
    rel_freqs   = get_rel_freqs(count_matrix)
    top_indexes = rel_freqs.argsort()[::-1][:n] 
    for i in top_indexes:
        print str(rel_freqs[i])  + " | " + str(count_matrix[:,i].sum()) + " | " + vocab.get(i)


# Calculate frequency discrepancy

# Rank most highly discrepant tokens


