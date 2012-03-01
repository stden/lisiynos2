program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

VAR m,n,i,j,c,r,l,lx,ls,lxs,y,ys:integer;
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

{r:=round(sqrt(2*m));
for i:= r downto 1 do begin
  if i*(i+1)/2=m then begin
    c:=i;
    break;
  end;
  if i*(i+1)div 2<m then begin
    c:=i;
    break;
  end;
end;
s:='';
for i:=1 to c do begin
  s:=s+inttostr(i);
end;

  write(s[c]);}




end.
