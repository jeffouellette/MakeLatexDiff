#! /bin/zsh

# $1: name of the old project directory (older version)
# $2: name of the current project directory (current or newer version)
# $3: name of main project (defaults to "Paper")

main=${1:Paper}

cd $2
mkdir diff
mkdir diff/sections

cp ./* diff/
cp ./sections/* diff/sections/*

# makes a bunch of latex files with the diffs
latexdiff ../$1/${main}-auxmat.tex ${main}-auxmat.tex > diff/${main}-auxmat.tex
latexdiff ../$1/${main}.tex ${main}.tex > diff/${main}_diff.tex
for file in sections; do
  latexdiff ../$1/sections/${file} sections/${file} > diff/sections/$(basename ${filename} .tex).tex
done

pdflatex ${main}_diff
biber ${main}_diff
pdflatex ${main}_diff
pdflatex ${main}_diff
