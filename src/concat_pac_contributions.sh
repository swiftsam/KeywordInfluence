## Concatenate files on PAC contributions to candidates
## OpenSecrets.org requires a login for downloads, so files were downloaded
## manually from the following URLs
## http://www.opensecrets.org/myos/download.php?f=CampaignFin14.zip
## http://www.opensecrets.org/myos/download.php?f=CampaignFin12.zip
## http://www.opensecrets.org/myos/download.php?f=CampaignFin10.zip
## http://www.opensecrets.org/myos/download.php?f=CampaignFin08.zip
## http://www.opensecrets.org/myos/download.php?f=CampaignFin06.zip
## http://www.opensecrets.org/myos/download.php?f=CampaignFin04.zip
## http://www.opensecrets.org/myos/download.php?f=CampaignFin02.zip
## http://www.opensecrets.org/myos/download.php?f=CampaignFin00.zip
## from each of those files, 
## extract the pacs[YY].txt file and zip into pac_contrib.zip
## extract the cmtes[YY].txt file and zip into pac.zip

cd ../data

# unzip
unzip pac.zip
unzip pac_contrib.zip

# combine the per-cycle pac files
cat $(ls cmtes*.txt) > pac.csv
cat $(ls pacs*.txt) > pac_contrib.csv

# replace the field-enclosing pipes with quotes
cat pac.csv | tr \| \" > pac.tmp
cat pac_contrib.csv | tr \| \" > pac_contrib.tmp

rm pac.csv pac_contrib.csv
mv pac.tmp pac.csv
mv pac_contrib.tmp pac_contrib.csv

# there were some non-UTF8 characters in the pac.csv file
recode latin2..utf8 pac.csv

# remove the per-cycle pac files
rm cmtes*.txt
rm pacs*.txt



