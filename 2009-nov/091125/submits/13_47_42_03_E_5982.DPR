program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

VAR m,n,i,j,c,r,l:integer;
    lx,ls,lxs,y,ys:int64;
s:string;


begin
assign(input, 'e.in');
reset(input);
assign(output, 'e.out');
rewrite(output);

read(m);
lx:=1;
lxs:=1;
i:=1;
while lxs<=m  do begin
  inc(i);
  l:=lx+length(inttostr(i));
  ls:=lxs+l;
  y:=lx;
  ys:=lxs;
  lx:=l;
  lxs:=ls;
end;

c:=m-ys;

s:='';
for j:= 1 to i do
  s:=s+inttostr(j);

writeln(s[c]);

end.
