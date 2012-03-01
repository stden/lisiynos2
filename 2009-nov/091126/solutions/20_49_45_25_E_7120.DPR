{$apptype console}

var N:1..3999;
    t,i:integer;

function to_rome(n:integer): string;

const nd:array [1..13] of integer=(1,4,5,9,10,40,50,90,100,400,500,900,1000) ;
      sd:array [1..13] of string=( 'I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C','CD','D','CM', 'M');

var k:integer;
    s:string;
begin
s:='';
for k:=13 downto 1 do
while nd[k]<=n do begin
  n:=n-nd[k];
  s:=s+sd[k];
  if n=0 then break;
end;
to_rome:=s;
end;

begin
  assign(input,'roman.in'); reset(input);
  assign(output,'roman.out'); rewrite(output);
  ReadLn(t);
  For i:=1 To t Do Begin
    readln(N);
    WriteLn(to_rome(N));
  end;
end.



end.