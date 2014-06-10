import json
import requests
import os.path
import datetime
import time

datetime.datetime.now().time()

# Capitol Words API root for text
endpoint =  'http://capitolwords.org/api/1/text.json'

def log_error(page):
    print str(datetime.datetime.now().time()) + ' time out on ' + str(page)
    with open("data/words/errors.txt", "a") as error_log:
            error_log.write('page_' + str(page).zfill(6) +',')

for page in range(1,48960):
  # check to see if we already have it
  file_path = 'data/words/page_' + str(page).zfill(6) + '.txt'
  if not os.path.isfile(file_path):
    time.sleep(2)
    print str(datetime.datetime.now().time()) + ' getting ' + str(page)
    # query parameters
    query_params = {'apikey': '05ccd18a42b6443c908952f80fa17c19',
                    'sort': 'id asc',
                    'page': page}
    # call API
    try:
	response = requests.get(endpoint, params=query_params, timeout=1)
        results   = response.json()['results']
        if len(results) == 50:
            with open(file_path, 'w') as outfile:
                json.dump(results, outfile)
    except:
        log_error(page)


  #else:
    #print 'skipping ' + str(page)
