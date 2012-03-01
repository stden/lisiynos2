#!/bin/bash

if [ -d ../problems ]; then
	for problem in `ls ../problems/`; do
		if [ -d ../problems/$problem/pics ]; then
			for pic in `ls ../problems/$problem/pics/*.mp`; do
				name=`basename $pic .mp`
				for ext in 1 2 3 4 5 6 7 8 9 log; do
					rm -f $name.$ext
				done
			done
		fi
	done
fi

if [ -d pics ]; then
	for pic in `ls pics/*.mp`; do
		name=`basename $pic .mp`
		for ext in 1 2 3 4 5 6 7 8 9 log; do
			rm -f $name.$ext
		done
	done
fi

for file in *.tex; do
	name=${file%\.*}
	for ext in aux dvi log ps pdf toc; do
		rm -f $name.$ext
	done
done
