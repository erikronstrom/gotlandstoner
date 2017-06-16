#!/bin/sh
ulimit -S -n 1024
if [ -z $1 ]
then
  VERBOSE=-interaction=batchmode
fi
rm -f fredin.out
bin/generate-book-2.pl book 2 && lualatex $VERBOSE book/fredin.latex && mv fredin.pdf bok2.pdf
rm fredin.out
bin/generate-book-2.pl book 3 && lualatex $VERBOSE book/fredin.latex && mv fredin.pdf bok3.pdf
rm fredin.out
echo
