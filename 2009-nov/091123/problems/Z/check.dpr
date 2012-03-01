{$I trans.inc}
uses testlib, sysutils;

var a,b,c : int64;
begin
  a := inf.readLongint;
  b := inf.readLongint;
  c := ouf.readLongint;
  if (a+b) <> c then
    Quit(_WA,IntToStr(A)+'+'+IntToStr(B)+'='+IntToStr(A+B)+' выведено '+IntToStr(C));
  quit (_OK, '');
end.