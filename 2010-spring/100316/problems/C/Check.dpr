Uses TestLib;
 Var lf, rg: LongInt;

BEGIN
  lf:=ouf.ReadLongInt;
  rg:=ans.ReadLongInt;
  If lf=rg Then QUIT(_ok, '') Else
   If lf<rg Then QUIT(_wa, 'Выдано меньше') Else QUIT(_wa, 'Выдано больше');
END.