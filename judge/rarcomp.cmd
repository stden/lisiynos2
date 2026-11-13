@echo off
set PATH=%PATH%;C:\Program Files\WinRAR
if s%~x1==s.gz (
  call winrar e -y %1 *
  delay
  del %~dpn1.gz
  for %%a in (*) do copy %%a %~dpn1.gz
)
call winrar t -y %1
if errorlevel 1 goto fail
for /l %%a in (1,1,9) do call winrar e -y %1 0%%a.out
for /l %%a in (10,1,25) do call winrar e -y %1 %%a.out
set temp=
for %%a in (??.out) do set temp=%%a
echo %temp%
if t%temp%==t goto fail
copy %1 %~dpn1.exe
exit /b 0
:fail
echo Bad archive
exit /b 1
