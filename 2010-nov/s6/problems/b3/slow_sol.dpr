{$APPTYPE CONSOLE}

Uses SysUtils;

const FileName = 'b3';

var n,m : integer;
    a : integer;

procedure ReadData;
begin
  Reset( input, FileName+'.in' );
  read(n,m);
end;

procedure WriteAnswer;
begin
  Rewrite( output, FileName+'.out' );
  writeln(a);
end;

procedure Solve;
var i,j,k:integer;
begin
  a:=0;
  for i:=1 to n do begin
    j:=i;
    k:=0;
    while j>0 do begin
      k:=k+j mod 10;
      j:=j div 10;
    end;
    if k mod m = 0 then inc(a);
  end;
end;

begin
  ReadData;
  Solve;
  WriteAnswer;
end.
