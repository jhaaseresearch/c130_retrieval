# !/bin/bash

: << 'CONVENTION'
Downloads NHC POD as a .txt file from NHC POD website.

INPUT: None

OUTPUT: YYYY-MM-DD_pod.txt
CONVENTION

dropbox_path="$HOME/agsd Dropbox/agsd's shared workspace"
pod_path=$dropbox_path'/data_temp/ar26_usaf_aro/nhc_pod'

# navigate to NHC POD archive folder
cd "$pod_path"

date=$(date "+%Y-%m-%d")

# use nhc plan of day website
curl https://www.nhc.noaa.gov/text/MIAREPRPD.shtml > "$date"_pod.txt
start=$(grep -n "REPRPD" "$date"_pod.txt | cut -d: -f1)
line_start=$((start - 1))
line_end=$(grep -n "NNNN" "$date"_pod.txt | cut -d: -f1)

# keeps only the lines we need
sed -i '' ''$line_start','$line_end'!d' "$date"_pod.txt