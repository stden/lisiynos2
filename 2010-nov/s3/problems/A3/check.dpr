uses testlib, sysutils;

var Contestant, Jury : String;
begin
  Contestant := Trim(ouf.ReadString);
  Jury := Trim(ans.ReadString);
  if Contestant<>Jury then
    QUIT(_WA,'Contestant "'+Contestant+'" <> "'+Jury+'"')
  else
    QUIT(_OK,'');
end.

