#!/bin/bash

#set -e

RETRIES=0
USE_IGNORE=''
APP='yt-dlp'

#function showopts() {
  while getopts ":ier:y:" optname;  do
      case "$optname" in
        "i") USE_IGNORE=-i    ;;
        "e") set -e           ;;
        "r") RETRIES=$OPTARG  ;;
        "y") APP=$OPTARG;;
        "?") echo "Unknown option $OPTARG"                 ;;
        ":") echo "No argument value for option $OPTARG"   ;;
        *)   echo "Unknown error while processing options" ;;
      esac
  done
#  return $OPTIND
#}




#optinfo=$(showopts "$@")
#showopts
#argstart=$?



#echo "Options are:"
#echo "optinfo is '''$optinfo'''"
#echo "argstart is $argstart"

#arrVar=()
#for var in "$@"; do
#    if [ "$var" = "-i" ]; then
#        USE_IGNORE=-i
#    elif [ "$var" = "-e" ]; then
#        set -e
#    elif [ "$var" = "-r" ]; then
#        shift 1
#        RETRIES=$var
#    else
#        arrVar+=("$var")
#    fi
#done

echo "ignore is '$USE_IGNORE'"
echo "retries is $RETRIES"

#shift $(expr $argstart - 1)
shift $(expr $OPTIND - 1)

arrVar=$@

#for i in ${@}; do
for var in ${arrVar[@]}; do
    echo "val '$var'"
done

#exit 1
errVar=()

#exit
if [ ${#arrVar[@]} -gt 0  ]; then
    for var in ${arrVar[@]}; do
    #for var in "${arrVar[@]}"; do
        echo "running $var"

        n=$(expr $RETRIES + 1)

        for i in {1..$n}; do
            #youtube-dl -i --config-location $var.conf
            echo "$APP $USE_IGNORE --config-location $var.conf"
            #mkdir -p "$var"
            "$APP" $USE_IGNORE --config-location $var.conf

            if [ $? -eq 0 ]; then
                echo "OK"
                errVar+=("$var OK")

                break
            else
                echo "FAIL"
                errVar+=("$var err")
                sleep 300
            fi
        done
    done

    for var in "${errVar[@]}"; do
        echo "result '$var'"
    done

    exit 0
fi

echo "no input"

#function gogo() {
#	youtube-dl --config-location config/$1.conf
#}

#echo "'$var' run successfully!"
#	#youtube-dl --config-location config/$1.conf
#gogo music
#gogo 480
#gogo best
#gogo 720
#gogo 1080

###while :
###do

###	sleep 900
#if [ $? -eq 0 ]; then
#	echo OK
#	break
#else
#   echo FAIL
#fi
#done


#youtube-dlc --config-location config/c480.conf

#youtube-dlc --config-location config/cbest.conf

###done
