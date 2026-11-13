program q;
var m,n,k: integer;
    f:text;

procedure rec(j,i:Integer);
begin
if (j<=n) and (i<=m) then begin
    if (i=m) and (j=n) Then k:=k+1
    else begin
         rec(j+2,i+1);
         rec(j+1,i+2);
    end;
end;
end;

begin
assign(f,'knight.in');
reset(f);
read(f,n,m);
close(f);
assign(f,'knight.out');
rewrite(f);
rec(1,1);
write(f,k);
close(f);
end.