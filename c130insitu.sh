# !/bin/bash

# assumes c130insitu.py was ran first!!

# create paths
dropbox_path="$HOME/agsd Dropbox/agsd's shared workspace/data_temp"
ags_path="$HOME/ags/products/hiaper"
ags2024="$ags_path/2024.162_tc2024/c130-insitu_usaf"
ags2025="$ags_path/2025.181_tc2025/c130-insitu_usaf"

echo -n "Enter TC campaign year (YYYY): "
read -r year

rename () {
    agsfile=($(find . -maxdepth 1 -name "*.txt")) # puts file name from c130-insitu-usaf in a list
    
    agsmissionname=() # cleans up $agsfile
    for file in "${agsfile[@]}"; do
        agsmission="${file:2}"
        # echo "agsfile is $file and remove first two is $agsmission"
        agsmissionname+=("$agsmission")
    done

    for line in "${pythonfilename[@]}"; do
        match="${line:11}"
        if [[ "${agsmissionname[*]}" == *"$match"* ]]; then
            echo "$match is present in both arrays. New file name is: $line."
            mv "$match" "$line"
        else
            echo "$match is not present in both arrays."
        fi
    done
}

if [[ $year == "2024" ]]; then
    echo "Campaign ID: 2024.162_tc2024"

    cd "$HOME/ags/projects/hiaper/code_kloo"

    pythonfilename=()
    for line in $(cat newfilename.txt);do 
        pythonfilename+=("$line") # .txt file to list
    done

    cd "$dropbox_path/tc24_usaf_aro/1_complete"
    one_second_data=$(find . -name "*01.txt")
    cp $one_second_data $ags2024
    cd "$ags2024"
    rename
elif [[ $year == "2025" ]]; then
    echo "Campaign ID: 2025.181_tc2025"

    cd "$HOME/ags/projects/hiaper/code_kloo"

    pythonfilename=()
    for line in $(cat newfilenametc25.txt);do 
        pythonfilename+=("$line") # .txt file to list
    done

    cd "$dropbox_path/tc25_usaf_aro/1_complete"
    one_second_data=($(find . -name "*01.txt"))
    for i in "${one_second_data[@]}";do
        cp $i $ags2025
    done
    cd "$ags2025"
    rename
fi

