# !/bin/bash/

: <<'CONVENTION'
This code moves the necessary data files from the 53rd Google Drive to agsd dropbox.
When expanding the .tgz file, the time files are renamed to comply with dropbox naming conventions.

INPUT: Flight date, storm name, tail number, and mission ID.

OUTPUT:
- new directory in "1_complete", titled "YYYY-MM-DD_STORM_TAIL"
- in this new directory, the .SUM, *.25_, and expanded .tgz files will be copied over.

CONVENTION

# local path to google drive 2025 NHOP folder
gdrive_path="$HOME/Library/CloudStorage/GoogleDrive-kloo@ucsd.edu/.shortcut-targets-by-id/1_L7QmkPn1WUVfeTuCeB04HKaOsed07O2/1 - 2025 Data/NHOP"
# local path to agsd's shared workspace
dropbox_path="$HOME/agsd Dropbox/agsd's shared workspace/data_temp/tc25_usaf_aro/1_complete"
# local path to your downloads folder
download_path="$HOME/Downloads/"
# local path to your desktop
desktop_path="$HOME/Desktop/"


# get file name input from user
echo -n "Enter flight date (YYYY-MM-DD): "
read -r date

echo -n "Enter storm name: "
read -r storm

echo -n "Enter tail number: "
read -r tail

echo -n "Enter mission ID: "
read -r mission

# extracts the month from $date
month="${date:5:2}"

# check if flight exists
cd "$gdrive_path"/"$month"*

if [ -d *"$mission"* ]; then
    # flight data has been upload, time to create directory to store data in agsd dropbox
    echo "Flight data exists."
    # go to tc25 usaf folder in dropbox
    cd "$dropbox_path"
    mkdir "$date"_"$storm"_"$tail"
else
    echo "Flight data has not been uploaded yet."
    exit
fi

# # following code will run if flight data exists

# copy .SUM file
cd "$gdrive_path"/"$month"*/*"$mission"*

if [ -e *.SUM ]; then
    echo ".SUM file exists."
    cp *.SUM "$dropbox_path"/"$date"_"$storm"_"$tail"
else
    echo ".SUM file doesn't exist, flight data is incomplete."
fi

# retrieve ARO file
cd "$gdrive_path"/"$month"*/*"$mission"*

arofile=$(find . -name "*.25*")

if [[ -z "${arofile[@]}" ]]; then # checks if $arofile string is empty
    echo "ARO file missing, data incomplete."
else
    # copy all ARO files (there will be 2 files if the flight occured past 00z)
    cp $arofile "$dropbox_path"/"$date"_"$storm"_"$tail"
    
    # rename ARO file
    cd "$dropbox_path"/"$date"_"$storm"_"$tail"
    for aro in $arofile; do
        if [[ "$aro" == *".25_.A" ]]; then
            mv "$aro" "${aro/.A/}"
        fi
    done

    # prints out the name of the fixed ARO file (good for verification)
    finalarofile=$(find . -name "*.25_")
    for final in $finalarofile; do
        echo "ARO file name: $final"
    done
fi

# retrieve tgz
cd "$gdrive_path"/"$month"*/*"$mission"*
if [ -e *.tgz ]; then
    echo ".tgz file exists."

    cp *.tgz ~/Desktop/launchpad
    cd $HOME/Desktop/launchpad
    tar -xzf *.tgz

    for file in *.txt; do
        mv "$file" "${file/\Data\\\\/}"
    done

    cp *.txt "$dropbox_path"/"$date"_"$storm"_"$tail"
    rm -f *
else
    echo ".tgz file doesn't exist, flight data is incomplete."
fi

echo "File name is "$date"_"$storm"_"$tail""
# cd "$dropbox_path"
# open "$date"_"$storm"_"$tail"
# open "$gdrive_path"/"$month"*/*"$mission"*