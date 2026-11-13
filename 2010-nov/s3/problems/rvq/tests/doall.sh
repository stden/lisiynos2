#!/bin/ bash

for i in *.hand; do
  cp "$i" "${i/\.hand/}"
done

fpc -Mdelphi dorand.dpr

echo 100    20     30     17    | ./dorand > 04
echo 200    1000   2000   177   | ./dorand > 05
echo 1000   50000  50000  1777  | ./dorand > 06
echo 789    17835  81642  17777 | ./dorand > 07
echo 4000   6713   9184   71    | ./dorand > 08
echo 7812   100000 0      711   | ./dorand > 09
echo 17890  0      100000 7111  | ./dorand > 10
echo 87123  835  100  71111 | ./dorand > 11
echo 100000 20     30     1234  | ./dorand > 12
echo 99999  200  3000   4321  | ./dorand > 13
echo 100000 500  500  12345 | ./dorand > 14
echo 100000 50  500  54321 | ./dorand > 15

rm -rf ../tests/
mkdir ../tests/
mv ?? ../tests/

