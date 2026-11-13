{ Check_A }
{$I trans.inc}

uses testlib, sysutils, Math;

var jury, cont : Extended;
begin
  jury := ans.ReadReal;
  cont := ouf.ReadReal;
  if abs(jury-cont)>1e-3 then
    quit(_WA, 'Jury: '+FloatToStr(jury)+', '+
              'Contestant: '+FloatToStr(cont));
  quit(_OK, '');
end.