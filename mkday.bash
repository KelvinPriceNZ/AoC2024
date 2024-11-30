#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR

if [[ -z $1 ]]
then
   echo "No day number provided"
   exit 1
fi

printf -v day "%02d" $1

[ ! -d $day ] && mkdir -p $day

#cp -p solve.py $day/part1.py
#cp -p solve.py $day/part2.py

./render_md.py $day

FILE="input/${day}/input.txt"
[ ! -d $(dirname $FILE) ] && mkdir -p $(dirname $FILE)

if [ ! -s ./${FILE} ]
then
   echo "Fetching $FILE"
   wget --no-cookies --header "Cookie: session=$(<./.token)" https://adventofcode.com/$(date +'%Y')/day/$1/input -O ${FILE}
else
   echo "$FILE already exists with data"
fi

head ${FILE}
tail ${FILE}
