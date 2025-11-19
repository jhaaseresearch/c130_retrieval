# !/bin/bash

# Note from Kelly 11/18/25: the dictionary has already been set for TC26

# make sure the directory is accurate to the campaign you are working on
dropbox_path=$HOME"/agsd Dropbox/agsd's shared workspace"
tt_path=$dropbox_path"/data_temp/tc26_usaf_aro/screenshot_tropical_tidbits"
nhc_path=$dropbox_path"/data_temp/tc26_usaf_aro/screenshot_nhc/"

# this is the only thing you have to actively change on an (almost) daily basis
active_storm=("12L" "13L") # Tropical Tidbits track and intensity projections
active_tc=("EP12" "EP13") # NOAA cone projections -- doesn't work for atlantic storms for now

date=$(date "+%Y-%m-%d")
# dictionary of storms
declare -A storm_names
# Atlantic storm
storm_names["01L"]="arthur"
storm_names["02L"]="bertha"
storm_names["03L"]="cristobal"
storm_names["04L"]="dolly"
storm_names["05L"]="edouard"
storm_names["06L"]="fay"
storm_names["07L"]="gonzalo"
storm_names["08L"]="hanna"
storm_names["09L"]="isaias"
storm_names["10L"]="josephine"
storm_names["11L"]="kyle"
storm_names["12L"]="leah"
storm_names["13L"]="marco"
storm_names["14L"]="nana"
storm_names["15L"]="omar"
storm_names["16L"]="paulette"
storm_names["17L"]="rene"
storm_names["18L"]="sally"
storm_names["19L"]="teddy"
storm_names["20L"]="vicky"
storm_names["21L"]="wilfred"
# Eastern Pacific storm
storm_names["01E"]="amanda"
storm_names["02E"]="boris"
storm_names["03E"]="cristina"
storm_names["04E"]="douglas"
storm_names["05E"]="elida"
storm_names["06E"]="fausto"
storm_names["07E"]="genevieve"
storm_names["08E"]="heman"
storm_names["09E"]="iselle"
storm_names["10E"]="julio"
storm_names["11E"]="karina"
storm_names["12E"]="lowell"
storm_names["13E"]="marie"
storm_names["14E"]="norbert"
storm_names["15E"]="odalys"
storm_names["16E"]="polo"
storm_names["17E"]="rachel"
storm_names["18E"]="simon"
storm_names["19E"]="trudy"
storm_names["20E"]="vance"
storm_names["21E"]="winnie"
storm_names["22E"]="xavier"
storm_names["23E"]="yolanda"
storm_names["24E"]="zeke"

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
# dictionary of storms
declare -A tc_names
# Eastern Pacific storm
tc_names["EP01"]="amanda"
tc_names["EP02"]="boris"
tc_names["EP03"]="cristina"
tc_names["EP04"]="douglas"
tc_names["EP05"]="elida"
tc_names["EP06"]="fausto"
tc_names["EP07"]="genevieve"
tc_names["EP08"]="heman"
tc_names["EP09"]="iselle"
tc_names["EP10"]="julio"
tc_names["EP11"]="karina"
tc_names["EP12"]="lowell"
tc_names["EP13"]="marie"
tc_names["EP14"]="norbert"
tc_names["EP15"]="odalys"
tc_names["EP16"]="polo"
tc_names["EP17"]="rachel"
tc_names["EP18"]="simon"
tc_names["EP19"]="trudy"
tc_names["EP20"]="vance"
tc_names["EP21"]="winnie"
tc_names["EP22"]="xavier"
tc_names["EP23"]="yolanda"
tc_names["EP24"]="zeke"

cd "$nhc_path/$date"
for i in "${active_tc[@]}"; do
    wget "https://www.nhc.noaa.gov/storm_graphics/"$i"/"$i"2025_5day_cone_no_line_and_wind.png"
    mv $i"2025_5day_cone_no_line_and_wind.png" $date"_${tc_names["$i"]}_cone.png"
    echo "Cone projection moved to Dropbox."
done

