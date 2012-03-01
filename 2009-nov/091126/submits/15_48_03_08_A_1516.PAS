type ordr = array[1..1000] of integer;
var
slog : string;
dict : array[1..1000] of string[10];
len : array[1..1000] of byte;
ll : array[1..1000] of char;
a,b,n,xm : integer;
ml : longint;
order,forder : ordr;
used : array[1..1000] of boolean;

function ll1(x:integer) : char;
var a : integer;
begin
a := 11;
repeat dec(a) until dict[x,a] in ['a'..'z'];
ll1 := dict[x,a];
end;

function len1(x:integer) : byte;
var a : integer;
begin
a := 11;
repeat dec(a) until dict[x,a] in ['a'..'z'];
len1 := a;
end;

function lent(x:integer): byte;
var a,c : integer;
begin
c := 0;
for a := 1 to x do
c := c+len[order[a]];
lent := c;
end;

function check(x : integer) : boolean;
var a,b,c : integer;
begin
c := 1;
check := false;
for a := 1 to x do
for b := 1 to len[order[a]]-1 do
begin
if dict[order[a],b] = slog[c] then
begin
inc(c);
if c > length(slog) then
begin
check := true;
exit;
end;
end;
{write(dict[order[a],b]);}
end;
if c = length(slog) then
if dict[order[x],len[x]] = slog[c] then
check := true;
{write(' ');}
end;

procedure nextword(x : integer);
var a,b : integer;
begin
if x = 1 then
for a := 1 to n do
begin
used[a] := true;
order[1] := a;
nextword(2);
used[a] := false;
end
else
begin
for a := 1 to n do
{if not used[a] then}
if ll[order[x-1]]=dict[a,1] then
begin
used[a] := true;
order[x] := a;
if not check(x) then
begin
if lent(x)<ml then
if x < n*10  then
nextword(x+1)
end
else
begin
if lent(x) < ml then
begin
ml := lent(x);
xm := x;
forder := order;
end;
end;
used[a] := false;
end
end;
end;

begin
assign(input,'chain.in');reset(input);
assign(output,'chain.out');rewrite(output);
readln(slog);
readln(n);
ml := 10001;
xm := 0;
for a := 1 to n do
readln(dict[a]);
for a := 1 to 1000 do order[a] := 0;
for a := 1 to n do len[a] := len1(a);
for a := 1 to n do ll[a] := ll1(a);
for a := 1 to 1000 do used [a] := false;
nextword(1);
if xm > 0 then
for a := 1 to xm do
writeln(dict[forder[a]])
else
writeln('?');
end.
