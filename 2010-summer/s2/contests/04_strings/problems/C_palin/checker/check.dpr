
program macro;
uses testlib;
var jury, cont : string;
begin
  jury:=ans.readstring;
  cont:=ouf.readstring;
  if not ouf.seekeof then quit (_pe, 'EOF expected');
  if cont<>jury then quit (_wa, 'Required: '+jury+', got: '+cont);
  quit (_ok, '');
end.