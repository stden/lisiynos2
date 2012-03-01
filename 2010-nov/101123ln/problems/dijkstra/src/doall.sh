#!/bin/sh

function doall_fail()
{
  echo "error:" $*
  exit 1
}

fpc gen.pas || doall_fail "compile failed [gen]"
fpc gen2.pas || doall_fail "compile failed [gen2]"
fpc gen3.pas || doall_fail "compile failed [gen3]"
g++ -O2 -Wall ../dijkstra_b3.cpp -o dijkstra_b3.exe || doall_fail "compile failed [dijkstra_b3]"

rm -rf ../tests/
mkdir ../tests/

for i in 01 02 03 04 11; do
  cp $i.hand ../tests/$i || doall_fail "copy failed [$i.hand]"
done

./gen 10 10 10 10 > ../tests/05
./gen 10 100 30 20 > ../tests/06
./gen 666 1000 1035 30 > ../tests/07
./gen 777 1500 354 4656 > ../tests/08
./gen 430 2000 50 500 > ../tests/09
./gen 332 2000 100 10000 > ../tests/10

# added by: Ivan Kazmenko
./gen2   10    1 10000 10000 12545 > ../tests/12
./gen3   10    10     0 12648 > ../tests/13
./gen3   10  1001     1 12749 > ../tests/14

./gen  999  2000 1000 10000 > ../tests/15
./gen  998  2000 2000 10001 > ../tests/16
./gen  997  5000 3000 10002 > ../tests/17
./gen 1000 10000 4900 10003 > ../tests/18

./gen2 1000    1 10000 10000 12345 > ../tests/19
./gen2 1000    5  9999 10000 12346 > ../tests/20
./gen2 1000   44     0 10000 12347 > ../tests/21
./gen2 1000  999 10000 10000 12348 > ../tests/22

./gen3 1000     1     0 12349 > ../tests/23
./gen3 1000     9     1 12350 > ../tests/24

for i in ../tests/??; do
  echo $i
  cp $i dijkstra.in
  ./dijkstra_b3.exe
  mv dijkstra.out $i.a
  rm dijkstra.in
done
