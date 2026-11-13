#!/bin/sh

function doall_fail()
{
  echo "error:" $*
  exit 1
}

g++ -O2 -Wall ../negcycle_b3.cpp -o negcycle_b3.exe || doall_fail "compile failed [negcycle_b3]"

rm -rf ../tests/
mkdir ../tests/

for i in ??.manual; do
  cp $i ../tests/${i%.manual} || doall_fail "copy failed [$i]"
done

for i in do??.dpr; do
  fpc $i || doall_fail "compile failed [$i]"
  name=${i%.dpr}
  name2=${name#do}
  ./$name >../tests/$name2
done

for i in ../tests/??; do
  echo $i
  cp $i negcycle.in
  ./negcycle_b3.exe
  mv negcycle.out $i.a
  rm negcycle.in
done
