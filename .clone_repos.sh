#!/bin/bash


HELP="help"

# silahkan isi batch-nya
# contoh: "rmt-010-jersey-fox"
BATCH="rmt-010-jersey-fox"

# silahkan isi path repos.json yang sudah anda letakkan.
# example "/home/dzakki/repos.json" 
PATH_REPOS="/home/dzakki/repos.json" 

# REPOSLIST=$(jq -r $WD "$PATH_REPOS")
# echo $REPOSLIST


function clonerp(){

    # WD = WEEK DAY
    WD=".$1"
    REPOSLIST=$(jq -r $WD "$PATH_REPOS")
    # REPOSLIST=$(jq -r '.asa' "$PATH_REPOS")
    # echo $REPOSLIST
    # echo $1
    if [ -z $1 ]; then
        echo ':: Usage   : clonerp w<week>d<day>'
        printf ":: Example : clonerp w1d2"
        echo
    elif [ $( echo $REPOSLIST | jq 'length') = 0 ]; then
        echo "Week Day yang anda maksud, tidak di temukan. silahkan liat week day di bawah ini:"
        echo $(jq -r '.' "$PATH_REPOS") | jq
    else 
        COUNTER=0
        for item in $(echo "${REPOSLIST}" | jq -r '.[] | @text'); do
            git clone "git@github.com:$BATCH/$item.git"
            COUNTER=$[$COUNTER +1]
        done
        echo "Yeay.. berhasil clone repos, dengan total: $COUNTER"
    fi

}


