@echo off
set CURRENT=090709
latex %CURRENT%
dvips -t landscape %CURRENT%
dvipdfm -p a4 -l %CURRENT%
rem dvips %CURRENT%
rem dvipdfm -p a4 %CURRENT%
