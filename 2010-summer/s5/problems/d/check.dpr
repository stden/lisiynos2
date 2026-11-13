{$I trans.inc}
program macro;
uses testlib;
const eps=1.1e-6;
var jury, cont:extended;
begin
  jury:=ans.readreal;
  cont:=ouf.readreal;
  if abs (jury-cont)>eps then quit (_wa, 'Требовалось '+r2s (jury)+', а получено '+r2s (cont));
  quit (_ok, '');
end.