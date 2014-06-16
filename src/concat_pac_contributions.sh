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
## from each of those files, extract the pacs[YY].txt file and zip into pacs.zip

cd ../data

# unzip
unzip pacs.zip

# combine the per-cycle pac files
cat $(ls pacs*.txt) > pac.csv

# replace the field-enclosing pipes with quotes
cat pac.csv | tr \| \" > pac.csv 

# remove the per-cycle pac files
rm pacs*.txt


