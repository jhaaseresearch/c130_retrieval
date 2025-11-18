# !/bin/bash

: << 'CONVENTION'
This code saves Tropical Tidbit screenshots. This includes storm information.
For flights, do not change the file name when you save it from the website.

INPUT:
- User input: aircraft type (+ mission if the same aircraft has multiple missions)

OUTPUT: 
- Recon screenshots moved to /screenshot_tropical_tidbits/DATE_TAIL

CONVENTION

# # path
dropbox_path="$HOME/agsd Dropbox/agsd's shared workspace"
tt_path="$dropbox_path""/data_temp/hiaper/2026.*_ar2026_datalog/tropical_tidbit_screenshot"
aircraft_path="$tt_path/aircraft_imgs_unsorted"
date=$(date "+%Y-%m-%d")
time=$(date "+%H:%M:%S")

# create directory for the day
cd "$tt_path"
mkdir "$date"

# Find the file
mv "$aircraft_path/*" "$tt_path/$date"

# rename the file
cd "$tt_path/$date"


echo "Tropical Tidbits flight screenshots moved."
