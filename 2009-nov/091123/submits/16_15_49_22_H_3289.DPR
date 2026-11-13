const nm  =  20;
type tcal  =  double;
     tsp = array [1..nm,  1..nm,  1..nm] of tcal;
var i,  j,  p,  n,  x,  y,  z  :  byte;
    s  :  tcal;
    sp : tsp;

function f(x, y, z : byte) : tcal;
var i : byte;
    s : tcal;
begin
  if sp[x, y, z] =  - 1 then
  begin
   s  := 0;
   for i  := 1 to x - 1 do s  := s + f(i, y - 1, z - 1);
   for i  := x + 1 to y do s  := s + f(x, y - 1, z);
   sp[x, y, z]  := s;
  end;
  f  := sp[x, y, z];
end;

begin
reset(input, 'h.in');
rewrite(output, 'h.out');
 readln(n, p);
 for x  := 1 to n do
  for y  := 1 to n do
   for z  := 1 to n do
    begin
      sp[x, y, z]  :=  - 1;
      if (z = 1) and (x <> 1) then sp[x, y, z]  := 0;
      if (y = z) and (x = y) then sp[x, y, z]  := 1;
    end;
   s  := 0;
   for i  := 1 to n do
    s  := s  +  f(i, n, p);
   writeln(s:0:0);
end.
