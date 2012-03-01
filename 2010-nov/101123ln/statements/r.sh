#!/bin/bash

for problem in `ls ../problems/`; do
	if [ -d ../problems/$problem/pics ]; then
		for pic in `ls ../problems/$problem/pics/*.mp`; do
			mp $pic || mpost $pic || metapost $pic || exit 1
		done
	fi
done

if [ -d pics ]; then
	for pic in `ls pics/*.mp`; do
		mp $pic || mpost $pic || metapost $pic || exit 1
	done
fi

for file in *.tex; do
	name=${file%\.*}
	latex $name.tex || exit 1
	latex $name.tex || exit 1
#	dvips -t a4 -t landscape $name.dvi -o $name.ps
#	dvipdfm -p a4 -l $name.dvi
	dvips -t a4 $name.dvi -o $name.ps
	dvipdfm -p a4 $name.dvi
done
