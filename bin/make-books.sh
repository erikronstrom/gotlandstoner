#!/bin/sh
ulimit -S -n 1024
if [ -z $1 ]
then
  VERBOSE=-interaction=batchmode
fi
rm -f fredin.out
bin/generate-book-2.pl book 2 && lualatex $VERBOSE book/fredin.latex && mv fredin.pdf bok2-raw.pdf && \
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=bok2.pdf bok2-raw.pdf
rm fredin.out
rm bok2-raw.pdf
bin/generate-book-2.pl book 3 && lualatex $VERBOSE book/fredin.latex && mv fredin.pdf bok3-raw.pdf && \
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=bok3.pdf bok3-raw.pdf
rm fredin.out
rm bok3-raw.pdf
echo
