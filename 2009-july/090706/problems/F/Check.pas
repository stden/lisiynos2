uses testLib, symbols;

var ansn, oufn : longint;

begin
  oufn := ouf.readlongInt;
  ansn := ans.readlongInt;

  if ansn <> oufn then
    QUIT(_WA,'Ожидалось '+str(ansn,0)+', а не '+str(oufn,0))
  else
    QUIT(_Ok,'');
end.
