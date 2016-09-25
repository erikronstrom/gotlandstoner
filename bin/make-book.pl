#!/bin/sh
ulimit -S -n 1024
bin/generate-ly-songs.pl $1 $2 && bin/generate-book-2.pl $1 $2 && \
lualatex -interaction=batchmode book/fredin.latex && open fredin.pdf
echo
