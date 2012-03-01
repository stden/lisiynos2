Program Explosion;
var OE,OAA,OA,OB,E,AA,A,B,All:int64;
    i,N:integer;
begin
  Assign(Input,'e3.in'); Reset(Input);
  Assign(Output,'e3.out'); Rewrite(Output);
  E:=0;AA:=0;A:=0;B:=1; All:=1;
  Readln(N);
  for i:=1 to N do begin
    OE:=E; OAA:=AA; OA:=A; OB:=B;
    E:=OE*2+OAA;
    AA:=OA;
    A:=OB;
    B:=OAA+OA+OB;
    All:=All*2;
  end;
  writeln(E);
end.