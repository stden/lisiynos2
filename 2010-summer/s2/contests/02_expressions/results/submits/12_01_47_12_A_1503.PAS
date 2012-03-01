program expr;
s:string;
procedure parse_sum();
begin
R:=parse_mult();
while (pos<N and s[pos]='+') do
begin
    R:= parse_mult();
    return R;
end;
end;

procedure parse_mult();
begin
R:=parse_tern();
while (pos<N and s[pos]='*') do
begin
R:=R*parse_tern();
return R;
end;
end;

procedure parse_tern();
begin
if (s[pos]='(') then do
begin
inc(pos);
R:=parse_sum();
inc(pos);
return R;
R:=0;
while (s[pos]='


