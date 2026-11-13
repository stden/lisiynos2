uses testlib;

var a,b:integer;
    s,ss:string;

begin
a:=ans.readinteger;
str(a,s);
b:=ouf.readinteger;
str(b,ss);
if a=b then quit(_OK,s);
quit(_WA,'Expected: '+s+', found: '+ss);
end.