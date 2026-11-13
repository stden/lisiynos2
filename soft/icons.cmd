@echo off
net user Olymp /add
del "%ALLUSERSPROFILE%\Рабочий стол\*."
del "%ALLUSERSPROFILE%\Рабочий стол\*.lnk"
del "C:\Documents and Settings\Olymp\Рабочий стол\*."
del "C:\Documents and Settings\Olymp\Рабочий стол\*.lnk"
del "%USERPROFILE%\Рабочий стол\*."
del "%USERPROFILE%\Рабочий стол\*.pif"
del "%USERPROFILE%\*.lnk"
move "%USERPROFILE%\Рабочий стол\*.exe" "C:\SOFT"


IF EXIST C:\olymp\soft\far\far.exe (
  echo FAR is good :)
) ELSE (

)

SET SRC=\\Teacher3a\netc

copy "%SRC%\icons\*.*" "%USERPROFILE%\Рабочий стол"
copy "%SRC%\icons\*.*" "C:\Documents and Settings\Olymp\Рабочий стол"
set path=%path%;C:\olymp\soft\far\Plugins\colorer\bin
C:
cd C:\olymp\soft\far\Plugins\colorer\bin
call C:\olymp\soft\far\Plugins\colorer\bin\setup.bat

copy "%ALLUSERSPROFILE%\Главное меню\Программы\Borland Delphi 7\Delphi 7.lnk" "C:\Documents and Settings\Olymp\Рабочий стол\Delphi 7.lnk"
copy "%ALLUSERSPROFILE%\Главное меню\Программы\Borland Delphi 7\Delphi 7.lnk" "%USERPROFILE%\Рабочий стол\Delphi 7.lnk"
copy "%SRC%\Ярлык для icons.lnk" "%ALLUSERSPROFILE%\Главное меню\Программы\Автозагрузка\Ярлык для icons.lnk"

