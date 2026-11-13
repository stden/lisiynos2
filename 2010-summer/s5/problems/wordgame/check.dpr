{$I trans.inc}
uses testlib, sysutils;
var jury, cont:string;
begin
  jury:=StripSpaces (UpperCase (ans.readstring));
  cont:=StripSpaces (UpperCase (ouf.readstring));
  if (cont<>'NO') and (cont<>'YES') then quit (_Fail, 'YES or NO required');
  if (cont<>'NO') and (cont<>'YES') then quit (_PE, 'YES or NO required');
  if jury<>cont then quit (_WA, 'Jury: '+jury+', Contestant: '+cont);
  quit (_OK, '');
end.