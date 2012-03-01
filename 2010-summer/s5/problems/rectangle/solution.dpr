{$APPTYPE CONSOLE}

Uses SysUtils;

Const FileName = 'rectangle';

{ Решение задачи B }
Var X1,Y1,X2,Y2,X3,Y3,X4,Y4,H1,H2,H3:LongInt;
begin
  Reset( input, FileName+'.in' );
  Rewrite( output, FileName+'.out' );
  Readln(X1,Y1,X2,Y2,X3,Y3); 
  H1:=Sqr(X2-X3)+Sqr(Y2-Y3);
  H2:=Sqr(X3-X1)+Sqr(Y3-Y1);
  H3:=Sqr(X1-X2)+Sqr(Y1-Y2);
  If ((H1>H2) And (H1>H3)) then 
    Begin X4:=X3-X1+X2; Y4:=Y3-Y1+Y2; End 
  Else
    If ((H2>H3) And (H2>H1)) then 
      Begin X4:=X1-X2+X3; Y4:=Y1-Y2+Y3; End 
    Else
      Begin X4:=X2-X1+X3; Y4:=Y2-Y1+Y3; End;
  Writeln(X4,' ',Y4);
end.
