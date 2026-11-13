USES TestLib;
 Var lf, rg: LongInt;

BEGIN
 lf:=ouf.ReadLongInt;
 rg:=ans.ReadLongInt;
 If lf<rg Then QUIT(_wa, 'Выдано меньше') Else
  If lf>rg Then QUIT(_wa, 'Выдано больше') Else
    QUIT(_ok, '');
END.