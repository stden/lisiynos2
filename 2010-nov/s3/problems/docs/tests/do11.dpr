{$apptype console}
const
    max = 1234791;

  n = 10000;
  m = 500;
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
  randseed := 2344213;
  writeln(n);
  k:=n;
  while k>0 do begin 
    for i:=300 downto 1 do begin
      writeln((i-1)*2+1+random(5),' ',next);
      dec(k); 
      if k=0 then break;
    end;
    for i:=1 to 300 do begin
      writeln((i-1)*2+1+random(5),' ',random(10000000)+1);
      dec(k); 
      if k=0 then break;
    end;
  end;
  k:=m;
  writeln(k);
  while k >0 do begin
    for i:=1 to 300 do begin
      writeln((i-1)*2+1,' ',(i-1)*2+4);
      dec(k); 
      if k=0 then break;
    end;
    for i:=300 downto 1 do begin
      writeln((i-1)*2+1,' ',(i-1)*2+4);
      dec(k); 
      if k=0 then break;
    end;
  end;  
end.