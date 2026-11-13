@echo off
call "C:\Program Files\Microsoft Visual Studio 8\Common7\Tools\vsvars32.bat"
set temp=c:\temp
set tmp=c:\temp
"C:\Program Files\Microsoft Visual Studio 8\VC\Bin\cl.exe" %*
