{$APPTYPE CONSOLE}
uses
  testlib, sysutils;

var User,Jury:String;
begin
  User := ouf.readString;
  Jury := ans.readString;
  if User <> Jury then
    quit(_wa, Format('User = %s  Jury = %s',[User,Jury]))
  else
    quit(_ok, '');
end.
