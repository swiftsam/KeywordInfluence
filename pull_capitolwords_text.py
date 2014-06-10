import urllib3
import json
import os.path
import datetime
import time
from multiprocessing import Pool

# Capitol Words API root for text
api_root = '/api/1/text.json?'
http     =  urllib3.connection_from_url('http://capitolwords.org')

def log_error(page):
  print str(datetime.datetime.now().time()) + ' time out on ' + str(page)
  with open("data/words/errors.txt", "a") as error_log:
    error_log.write('page_' + str(page).zfill(6) +',')

def pull_page(page):
  # check to see if we already have it
  file_path = 'data/words/page_' + str(page).zfill(6) + '.txt'
  if not os.path.isfile(file_path):
    print str(datetime.datetime.now().time()) + ' getting ' + str(page)
    # query parameters
    query_params = {'apikey': '05ccd18a42b6443c908952f80fa17c19',
                    'sort': 'id asc',
                    'page': page}
    # call API
    try:
      response = http.request('GET', api_root + urllib3.request.urlencode(query_params))
      results  = json.loads(response.data)['results']
      if len(results) == 50:
        with open(file_path, 'w') as outfile:
          json.dump(results, outfile)
    except:
      log_error(page)


workers = Pool(15)
workers.map(pull_page, range(35000))
