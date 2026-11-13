@echo off
call javapre %1
if errorlevel 1 goto err
echo no botva
exit
:err
echo botva
