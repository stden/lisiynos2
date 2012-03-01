{$apptype console}
{$r+,q+}
const
    max = 1234791;

  n = 1000;
  m = 100;
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
  randseed := 2466781;
  writeln(n);
  for i:=1 to n do begin
    writeln(random(1000000000)+1,' ',next)
  end;
  writeln(m);       
  for i:=1 to m do begin
    k:=random(1000000000)+1;
    j:=random(1000000000);
    if k+j>1000000000 then j := 1000000000 - k;
    writeln(k,' ',k+j);
  end;
end.