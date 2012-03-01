Program Prog;

uses
 SysUtils;
var
 n,m,i,j,g,l,k:integer;
 st:string;
begin
 reset(input, 'b.in');
 rewrite(output, 'b.out');
 read(n,m);
 k:= 0;
 for i := 1 to n do
  for j := 1 to i do begin
   st := IntToStr(i);
   for l := 1 to length(st) do begin
    write(st[l]);
    inc(k);
    if (k = m) then begin
      writeln('');
      k := 0;
     end;
    end;
   end;
end.
