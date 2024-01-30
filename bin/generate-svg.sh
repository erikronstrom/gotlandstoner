#!/bin/sh
svg=1 bin/generate-ly-songs.pl $1 $2
for ((i=$1;i<=$2;i++)); do
    echo "Rendering $i..."
    lilypond -l WARNING -dbackend=svg -dno-point-and-click -o "svg/$i-original" "book/song-$i.ly"
    bin/simplify-svg.pl < svg/$i-original.svg > svg/$i-simple.svg
    bin/trim-svg.pl < svg/$i-simple.svg > svg/$i-trimmed.svg
done
echo "Done!"
