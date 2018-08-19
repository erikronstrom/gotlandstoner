#!/bin/sh
ulimit -S -n 1024
OUTFILE=${3:-fredin.pdf}
if [ -z $4 ]
then
  VERBOSE=-interaction=batchmode
fi
bin/generate-book-2.pl $1 $2 && \
lualatex $VERBOSE book/fredin.latex && \
mv fredin.pdf raw-$OUTFILE && \
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$OUTFILE raw-$OUTFILE && \
open $OUTFILE
echo
