{$I trans.inc}
program macro;
uses testlib;
var jury, cont:extended;
begin
  jury:=ans.readreal;
  cont:=ouf.readreal;
  if int (jury)<>jury then quit (_fail, 'Not an integer');
  if int (cont)<>cont then quit (_pe, 'Not an integer');
  if not ouf.seekeof then quit (_pe, 'EOF expected');
  if jury<>cont then quit (_wa, 'Wrong number');
  quit (_ok, '');
end.