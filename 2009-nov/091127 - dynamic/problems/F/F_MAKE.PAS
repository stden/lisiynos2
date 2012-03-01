Program Explosion;
var OE,OAA,OA,OB,E,AA,A,B:longint;
    i,N:byte;
begin
  Assign(Input,ParamStr(1)); Reset(Input);
  Assign(Output,ParamStr(2)); Rewrite(Output);
 E:=0;AA:=0;A:=0;B:=1;
 Readln(N);
 for i:=1 to N do
  begin
   OE:=E;OAA:=AA;OA:=A;OB:=B;
   E:=OE*2+OAA;
   AA:=OA;
   A:=OB;
   B:=OAA+OA+OB;
  end;
 writeln(E);
end.