uses testlib;

var a,b,c,d:integer;
    s,ss:string;

begin
a:=ouf.readinteger;
b:=ouf.readinteger;
c:=ans.readinteger;
d:=ans.readinteger;
if (a=c) and (b=d) then quit(_OK,'');

str(a,s);
str(b,ss);
s:='Found: '+s+' '+ss+', expected: ';
str(c,ss);
s:=s+ss+' ';
str(d,ss);
s:=s+ss;
quit(_WA,s);
end.
