#!/bin/bash

cd ../data/influence

### contributions
wget http://datacommons.s3.amazonaws.com/subsets/td-20120907/contributions.fec.csv.zip
unzip contributions.fec.csv.zip
rm contributions.fec.csv.zip

### lobbying
wget http://datacommons.s3.amazonaws.com/subsets/td-20121001/lobbying.zip
unzip lobbying.zip
rm lobbying.zip
mv README README.opensecrets