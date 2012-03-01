@echo off
set path=C:\Progra~1\Java\jdk1.6.0_22\bin
echo %~dpn1
C:\Progra~1\Java\jdk1.6.0_22\bin\javac %~dpn1.java
if not exist %~dpn1.class goto fail
C:\Windows\rar.exe a %~dpn1.exe *.class
:exit
exit /b 0
:fail
echo Compilation failed
exit /b 1
