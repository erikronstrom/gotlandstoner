#!/bin/sh
bin/generate-ly-songs.pl $1 $2 && bin/generate-book-2.pl $1 $2 && \
lualatex -interaction=batchmode book/fredin.latex && open fredin.pdf
echo
