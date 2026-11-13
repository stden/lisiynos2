{$APPTYPE CONSOLE}
{$O-,Q+,R+}

uses
  testlib, sysutils;

var
  a:Int64; b:Integer; m:Int64;
  Tests,Test : Integer;
  Jury,User : Int64;
begin
  Tests := inf.readlongint;
  for Test := 1 to Tests do begin
    Jury := ans.ReadLongint;
    User := ouf.ReadLongint;
    if Jury<>User then
      Quit(_WA,'Jury:'+IntToStr(Jury)+'<>User:'+IntToStr(User));
  end;
  Quit(_ok, 'You win!!!');
end.