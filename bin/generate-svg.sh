#!/bin/sh
svg=1 bin/generate-ly-songs.pl $1 $2
for ((i=$1;i<=$2;i++)); do
    echo "Rendering $i..."
    lilypond -l WARNING -dbackend=svg -dno-point-and-click -o "svg/$i" "book/song-$i.ly"
done
bin/trim-svg.pl
echo "Done!"
