#!/bin/sh
for ((i=$1;i<=$2;i++)); do
    abc2midi "abc/song-$i.abc" -o "midi/$i.mid"
done
echo "Done!"
