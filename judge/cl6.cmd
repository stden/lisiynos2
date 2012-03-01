@echo off
set "path=C:\Program Files\Microsoft Visual Studio\VC98\Bin;C:\Program Files\Microsoft Visual Studio\Common\MSDev98\Bin;%path%"
set libpath=C:\Program Files\Microsoft Visual Studio\VC98\Lib
set lib=C:\Program Files\Microsoft Visual Studio\VC98\Lib
set temp=c:\temp
set tmp=c:\temp
"C:\Program Files\Microsoft Visual Studio\VC98\Bin\cl.exe" %* "/IC:\Program Files\Microsoft Visual Studio\VC98\Include" 
rem "/link/libpath:C:\Program Files\Microsoft Visual Studio\VC98\Lib" 
