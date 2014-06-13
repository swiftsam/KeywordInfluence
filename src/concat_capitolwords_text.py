import os.path
from os import listdir
import json
import pandas as pd
import numpy as np

file_path = "data/words/by_bioguide/"
files     = sorted(list(listdir(file_path)))
if "errors.txt" in files:
	files.remove("errors.txt")

print "loading data from " + str(len(files)) + " files"

for file_name in files:
	print file_name
	if os.path.isfile(file_path + file_name) and os.stat(file_path + file_name).st_size:
		
		# read JSON file for a single congressperson
		df = pd.read_json(file_path + file_name)

		# modify columns
		df['n_sentence'] = df.speaking.apply(np.size)
		df['speaking']   = df.speaking.apply(" ".join)

		# concatenate into a single file
		if file_name == files[0]:
			df.to_csv("data/words.csv", header=True, mode='w', encoding='utf-8')
		else:
			df.to_csv("data/words.csv", header=False, mode='a', encoding='utf-8')



