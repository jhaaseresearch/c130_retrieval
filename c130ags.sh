# !/bin/bash

: <<'CONVENTION'
This code creates sbf file in ags, then copies the ARO file over. This is the step prior to running 0B for data processing.
Prior to running script, ensure that Dropbox and ags is mounted to your local machine.

INPUT: User input upon prompt.

OUTPUT:
- New directory created in data/hiaper/CAMPAIGN/gpsdata_asterxsb3/sbf
- ARO file is copied to sbf folder
CONVENTION

dropbox_path="$HOME/agsd Dropbox/agsd's shared workspace"

echo -n "Enter flight date (YYYY-MM-DD): "
read -r date
doy=$(date -j -f "%Y-%m-%d" "$date" +%j)
year="${date:0:4}"
y="${date:2:2}"
# echo $year

echo -n "Enter ARO flight ID: "
read -r flightid

echo -n "Enter aircraft receiver ID: "
read -r receiverID

# dictionary of receivers
declare -A receiver
receiver["a11t"]="af300"
receiver["a01t"]="af301"
receiver["a04t"]="af302"
receiver["a10t"]="af303"
receiver["a03t"]="af304"
receiver["a06t"]="af306"
receiver["a00t"]="af307"
receiver["a08t"]="af308"
receiver["a09t"]="af309"

createsbf () {
    cd $HOME/ags/data/hiaper/$campaign
    mkdir $year."$doy"_"$flightid"_"$receiverID"
    cd $year."$doy"_"$flightid"_"$receiverID"
    mkdir gpsdata_asterxsb3
    cd gpsdata_asterxsb3
    mkdir sbf
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "sbf file has been created"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
}
if [[ "$year" == "2025" ]]; then
    campaign="2025.181_tc2025"
    datatemp="tc25_usaf_aro"
    createsbf
    echo -n "Enter storm name: "
    read -r storm
    cp "$dropbox_path"/data_temp/"$datatemp"/1_complete/"$date"_"$storm"_"${receiver["$receiverID"]}"/"$receiverID"*."$y"_ $HOME/ags/data/hiaper/"$campaign"/"$year"."$doy"_"$flightid"_"$receiverID"/gpsdata_asterxsb3/sbf/
elif [[ "$year" == "2024" ]]; then
    campaign="2024.162_tc2024"
    datatemp="tc24_usaf_aro"
    createsbf
    cp "$dropbox_path"/data_temp/"$datatemp"/1_complete/"$year"."$doy"_*_"$receiver"/"$receiverID"*."$y"_ $HOME/ags/data/hiaper/"$campaign"/"$year"."$doy"_"$flightid"_"$receiverID"/gpsdata_asterxsb3/sbf/
fi

echo "~~~~~~~~~~~~~~~~~~~~~~~"
echo "ARO file copied to sbf."
echo "~~~~~~~~~~~~~~~~~~~~~~~"
