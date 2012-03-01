#!/bin/bash
source ./include.sh
./clean.sh

echo Compiling...
if [ -e ../$SOL.cpp ] ; then
	g++ -O2 -Wall ../$SOL.cpp -o $SOL.exe
fi

echo Generating tests...
if [ -e small.in ] ; then
	cat small.in >>$TASK.in
fi
if [ -e gen.py ] ; then
	python ./gen.py 01 >>$TASK.in
fi

echo Generating answers...
if [ -e ../$SOL.py ] ; then
python ../$SOL.py
else
./$SOL.exe
fi

echo Splitting tests...
python ./splittests.py

if [ ! -e ../tests ] ; then
	mkdir   ../tests
fi
mv ??    ../tests || mv ???   ../tests
mv ??.a  ../tests || mv ???.a ../tests
if $DOCLEAN ; then
	./clean.sh
fi
