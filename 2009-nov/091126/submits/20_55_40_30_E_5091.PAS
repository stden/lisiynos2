Program nepeBoD;
var
 a,b,i,n:integer;
 d,name:string;
q:array[1..100] of string;
begin
assign(input,'roman.in');
reset(input);
assign(output,'roman.out');
rewrite(output);
read(n);
for i:=1 to n do
begin
read(a);
 b:=a mod 10;
 a:=a div 10;
 case b of
  0: d:='';
  1: d:='I';
  2: d:='II';
  3: d:='III';
  4: d:='IV';
  5: d:='V';
  6: d:='VI';
  7: d:='VII';
  8: d:='VIII';
  9: d:='IX';
 end;
 b:=a mod 10;
 a:=a div 10;
 case b of
  0: d:=''+d;
  1: d:='X'+d;
  2: d:='XX'+d;
  3: d:='XXX'+d;
  4: d:='XL'+d;
  5: d:='L'+d;
  6: d:='LX'+d;
  7: d:='LXX'+d;
  8: d:='LXXX'+d;
  9: d:='XC'+d;
 end;
 b:=a mod 10;
 a:= a div 10;
 case b of
  0: d:=''+d;
  1: d:='C'+d;
  2: d:='CC'+d;
  3: d:='CCC'+d;
  4: d:='CD'+d;
  5: d:='D'+d;
  6: d:='DC'+d;
  7: d:='DCC'+d;
  8: d:='DCCC'+d;
  9: d:='CM'+d;
 end;
 b:=a mod 10;
 case b of
  0: d:=''+d;
  1: d:='M'+d;
  2: d:='MM'+d;
 end;
 q[i]:=d;
 end;
 for i:=1 to n do
 writeln(q[i]);
 end.
