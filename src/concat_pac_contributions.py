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

import zipfile

with zipfile.ZipFile('data/pacs.zip', "r") as z:
    z.extractall()

for pacyear in glob.glob('pacs*.txt'):
	


