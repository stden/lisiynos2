@echo off
copy %1. input.txt
square.exe
copy output.txt %1.a
draw.exe
check.exe input.txt output.txt output.txt ans.txt
type ans.txt