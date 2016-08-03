#!/bin/sh

pushd book
lilypond-book fredin.lytex && pdflatex fredin.tex && open fredin.pdf
popd
