#!/bin/sh
bin/generate-ly-songs.pl && bin/generate-book-2.pl 250 255 && pdflatex book/fredin.latex && open fredin.pdf
