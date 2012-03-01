program posl;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var i,q,j,k,w,e:integer;
a: array [1..60000] of longint; 
begin
  reset(input,'d.in');
  rewrite(output,'d.out');
read(i);

k:=1;
w:=1;
for j:=1 to i do begin

 for q:=1 to k do begin

  a[w]:=q;
   inc(w);
 end;
inc(k);
end;
write(a[i]);
end.
