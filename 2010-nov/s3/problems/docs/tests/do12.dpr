{$apptype console}
const
    max = 1234791;

  n = 10000;
  m = 10000;
var
  i,j,k:longint;

    h : array[1..max] of boolean;
    
function hash(a : longint) : longint;
var r : longint;
begin
    r := 17;    
    while (a <> 0) do
    begin
        r := (31 * r + (a mod 10)) mod max;
        a := a div 10;
    end;
    hash := r;
end;

function next : longint;
var r, z : longint;
begin
    r := random(100000000) + 1;
    z := hash(r);
    while h[z] do begin
        r := random(100000000) + 1;        
        z := hash(r);
    end;
    h[z] := true;

    next := r;
end;

begin
  randseed := 435872121;
  writeln(n);
  for i:=1 to n do writeln('239 ',next);
  writeln(m);
  for i:=1 to m do writeln('1 1000');
end.