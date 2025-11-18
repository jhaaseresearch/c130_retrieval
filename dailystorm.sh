# !/bin/bash

date=$(date "+%Y-%m-%d")
dropbox_path=$HOME"/agsd Dropbox/agsd's shared workspace"
tt_path=$dropbox_path"/data_temp/tc25_usaf_aro/screenshot_tropical_tidbits"
nhc_path=$dropbox_path"/data_temp/tc25_usaf_aro/screenshot_nhc/"

active_storm=("13L")

# dictionary of storms
declare -A storm_names
storm_names["13L"]="melissa"
storm_names["14L"]="nestor"
storm_names["19E"]="tico"
storm_names["92E"]="invest92e"

cd "$tt_path"
# cd "$HOME/Downloads"
for i in "${active_storm[@]}";do
    wget --referer='https://www.tropicaltidbits.com/' -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36' 'https://www.tropicaltidbits.com/storminfo/'$i'_tracks_latest.png'
    mv $i'_tracks_latest.png' $date"_${storm_names["$i"]}_track.png"
    wget --referer='https://www.tropicaltidbits.com/' -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36' 'https://www.tropicaltidbits.com/storminfo/'$i'_intensity_latest.png'
    mv $i'_intensity_latest.png' $date"_${storm_names["$i"]}_intensity.png"
done

open "$tt_path"

# NOAA cone projections -- doesn't work for atlantic storms
active_tc=()
# dictionary of storms
declare -A tc_names
tc_names["EP19"]="tico"

cd "$nhc_path/$date"
for i in "${active_tc[@]}"; do
    wget "https://www.nhc.noaa.gov/storm_graphics/"$i"/"$i"2025_5day_cone_no_line_and_wind.png"
    mv $i"2025_5day_cone_no_line_and_wind.png" $date"_${tc_names["$i"]}_cone.png"
    echo "Cone projection moved to Dropbox."
done

