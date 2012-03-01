#!/bin/bash

for i in *.hand; do
  cp "$i" "${i/\.hand/}"
done

fpc genall.dpr
./genall

rm -rf ../tests/
mkdir ../tests/
mv ?? ../tests/

