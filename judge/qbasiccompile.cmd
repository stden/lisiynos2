rem @echo off
C:\gassa\QB\bc.exe %~n1.bas %~n1.obj nul.lst
echo %~n1.exe>_qbfile_
echo nul.map>>_qbfile_
echo C:\gassa\QB\bcom45.lib>>_qbfile_
C:\gassa\QB\link.exe %~n1.obj <_qbfile_
erase _qbfile_
