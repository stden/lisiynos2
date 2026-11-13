{$apptype console}
const
    max = 1234791;
  n = 1000;
  m = 990;
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

  k:=m;
  randseed := 93246813;
  writeln(n);
  for i:=1 to n do writeln(random(8)+1,' ',next);
  writeln(k);
  while k >0 do begin
    for i:=1 to 3 do begin
      writeln((i-1)*2+1,' ',(i-1)*2+4);
      dec(k); 
      if k=0 then break;
    end;
    for i:=3 downto 1 do begin
      writeln((i-1)*2+1,' ',(i-1)*2+4);
      dec(k); 
      if k=0 then break;
    end;
  end;  
end.