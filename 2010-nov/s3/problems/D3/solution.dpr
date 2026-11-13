{$R+}
Program robot;
Var Way1,Way2:array [-26..26,-26..26] of Integer;
    X,Y,K,i,j,z,s:Integer;
begin
  Assign(Input,'d3.in'); Reset(Input);
  Assign(Output,'d3.out'); Rewrite(Output);

 readln(K,X,Y);
 for i:=-26 to 26 do
  for j:=-26 to 26 do
    Way1[i,j]:=0;
 Way1[0,0]:=1;
 for z:=1 to k do
  begin
   Way2:=Way1;
   for i:=-26 to 26 do
    for j:=-26 to 26 do
     begin
      s:=0;
      if i<>-26 then s:=s+Way2[i-1,j];
      if i<>26 then s:=s+Way2[i+1,j];
      if j<>-26 then s:=s+Way2[i,j-1];
      if j<>26 then s:=s+Way2[i,j+1];
      Way1[i,j]:=s;
     end;
  end;
 writeln(way1[x,y]);
end.