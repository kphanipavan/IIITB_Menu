# IIITB_Menu Excel File Scraper Code
Code for building the bi-weekly food menu database for use in the web app.
Two files are created, one of them is the JSON database file `menu.json` and the other is the md5 hash of the json data `hash.txt`. 
The app checks for update in hash and downloads the new menu file if required.
The menu stays persistently on the device's web cache allowing for offline app usage.

# Automation
The menu has to be downloaded from the shared Excel Online link as ODS, be loaded into pandas, save as CSV and pushed to this branch.
This will create a new release/file in the repo which are the sources for the web app.
