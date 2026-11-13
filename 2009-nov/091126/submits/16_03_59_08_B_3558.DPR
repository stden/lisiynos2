program dop;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
     a:array[1..100,1..100] of integer;
     n,i,j,k:integer;
begin
    assign(input,'color.in');
    reset(input);
    assign(output,'color.out');
    rewrite(output);
      read(n);
       k:=0;
       for i:=1 to n+2 do begin
for j:=1 to n do begin
         read(a[i,j]);
       end;end;
for i:=1 to n do begin
for j:=1 to n-(n-i) do begin
  if (a[i,j]=1) and (a[n+1,j]<>a[n+1,i])
   then inc(k);
       end;
      end;
write(k);
      close(input);
      close(output);
end.
