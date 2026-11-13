uses crt;
var a,b,c,d,e,i,j,l,N,r,pos:integer;
s:string;
function parse_term:integer; forward;
function parse_sum:integer; forward;
function parse_integer:integer;
var r:integer;
begin
 r:=0;
 while (ord(s[pos])>=ord('0')) and (ord(s[pos])<=ord('9')) do begin
  r:=r*10+ord(s[pos])-ord('0');
  inc(pos);
 end;
 parse_integer:=r;
end;
function parse_mult:integer;
 var r:integer;
 begin
  r:=parse_term;
  while (pos<=N) and (s[pos]='*') do
   begin
   inc(pos);
   r:=r * parse_term;
   end;
   parse_mult:=r;
 end;
function parse_sum:integer;
 var r:integer;
 begin
  r := parse_mult;
  while (pos<=N) and (s[pos]='+') do
   begin
   inc(pos);
   r:=r + parse_mult;
   end;
   parse_sum:=r;
 end;
function parse_term:integer;
 var r:integer;
 begin
  if(s[pos]='(') then
  begin
  writeln(pos);
   inc(pos);
   r:=parse_sum;
   inc(pos);
  end else begin
   r := parse_integer;
  end;

 parse_term:=r;
 end;

begin
 assign(input, 'expr.in'); reset (input);
 assign(output, 'expr.out'); rewrite (output);
 i:=1;
 pos:=1;

 read(s);
 while s[i] <> '.' do inc(i);
 N := i - 1;
 write(parse_sum);
end.