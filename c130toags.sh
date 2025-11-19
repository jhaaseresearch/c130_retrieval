# !/bin/bash

: <<'CONVENTION'
This code creates sbf file in ags, then copies the ARO file over. This is the step prior to running 0B for data processing.
The second function copies the corresponding 1 second text file, then renames it to AFxxx_FLIGHTID_MISSIONID.01.txt 
Prior to running script, ensure that Dropbox and ags is mounted to your local machine.

INPUT: User input upon prompt.

OUTPUT:
- New directory created in /ags/data/hiaper/CAMPAIGN/gpsdata_asterxsb3/sbf
- ARO file is copied to sbf folder
- 1 second data moved and renamed in /ags/products/hiaper/c130-insitu_usaf
CONVENTION

# the only thing you need to modify is the two variables below
campaign_id=2025.181_tc2025
dropbox_id=tc25_usaf_aro

# getting the preliminary information
dropbox_path="$HOME/agsd Dropbox/agsd's shared workspace/data_temp/$dropbox_id/1_complete"
hprd="$HOME/ags/data/hiaper/$campaign_id"
hprp="$HOME/ags/products/hiaper/$campaign_id/c130-insitu_usaf"

echo -n "Enter flight date (YYYY-MM-DD): "
read -r date
doy=$(date -j -f "%Y-%m-%d" "$date" +%j)
year="${date:0:4}"
y="${date:2:2}"

echo -n "Enter ARO flight ID: "
read -r flightid

echo -n "Enter aircraft receiver ID: "
read -r receiverID

echo -n "Enter mission ID: "
read -r mission

echo -n "Enter storm name: "
read -r storm

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

# establishes paths and file names
sbffile="$year"."$doy"_"$flightid"_"$receiverID"
sbffilepath="$hprd/$sbffile/gpsdata_asterxsb3/sbf/"
dropboxfile="$date"_"$storm"_"${receiver[$receiverID]}"
arofile="$receiverID""$doy""0.""$y""_"
arofilepath="$dropbox_path/$dropboxfile/$arofile"

createsbf () {
    # copies sbf file to /ags/data/hiaper/*
    cd $hprd
    mkdir "$sbffile"
    cd "$sbffile"
    mkdir gpsdata_asterxsb3
    cd gpsdata_asterxsb3
    mkdir sbf
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "sbf file has been created"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~"

    cp "$arofilepath" "$sbffilepath"
    echo "~~~~~~~~~~~~~~~~~~~~~~~"
    echo "ARO file copied to sbf."
    echo "~~~~~~~~~~~~~~~~~~~~~~~"
}
createproduct () {
    # copies sbf file to /ags/product/hiaper/*
    cd "$dropbox_path/$dropboxfile"
    cp "$mission.01.txt" "$hprp"

    # rename file
    cd "$hprp"
    tail=${receiver[$receiverID]^^}
    FLIGHTID=${flightid^^}
    mv "$mission".01.txt "$tail"_"$FLIGHTID"_"$mission".01.txt
    echo "1 sec data has been moved. File name is: "$tail"_"$FLIGHTID"_"$mission".01.txt"
}

# run functions
createsbf
createproduct


