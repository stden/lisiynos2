program qq;
var q:integer;
    f:text;
begin
q:=random(2);
assign(f,'nim.in');
rewrite(f);
if q=1 then write(f,'Second') else write(f,'First');
end.