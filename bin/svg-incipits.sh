#!/bin/sh

for ((i=$1;i<=$2;i++)); do
    bin/svg-incipit.pl svg/$i.svg > svg/$i-thumb.svg
done
cp svg/*-thumb.svg ~/Sites/gotlandstoner.se/web/svg/
