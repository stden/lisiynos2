program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var sum,b:int64;
i,a,n,j:integer;
cost:array[0..31] of integer;
begin
  reset(input,'teeth.in');
  rewrite(output,'teeth.out');
  for i:=0 to 31 do read(cost[i]);
  read(n);
  sum:=0;

  for i:=1 to n do begin
    read(a);

    for j:=31 downto 0 do begin
     b:=int64(1) shl j;
     if a>=b then begin
      a:=a-b;
      sum:=sum+cost[j];
     end;

    end;
  end;

  writeln(sum);
end.
