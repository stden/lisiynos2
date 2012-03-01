{$R+}

const Max = 26;

Var Way1,Way2:array [-Max..Max,-Max..Max] of int64;
    X,Y,K,i,j,z:shortint;
    s:int64;
begin
  Assign(Input,ParamStr(1)); Reset(Input);
  Assign(Output,ParamStr(2)); Rewrite(Output);

 readln(K,X,Y);
 for i:=-max to max do
  for j:=-max to max do
    Way1[i,j]:=0;
 Way1[0,0]:=1;
 for z:=1 to k do
  begin
   Way2:=Way1;
   for i:=-max to max do
    for j:=-max to max do
     begin
      s:=0;
      if i<>-max then s:=s+Way2[i-1,j];
      if i<>max then s:=s+Way2[i+1,j];
      if j<>-max then s:=s+Way2[i,j-1];
      if j<>max then s:=s+Way2[i,j+1];
      Way1[i,j]:=s;
     end;
  end;
 writeln(way1[x,y]);
end.