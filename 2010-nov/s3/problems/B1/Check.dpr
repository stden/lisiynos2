uses testlib;

var a,n:integer;
    c,d,i:integer;
    s,ss:string;

begin
a:=ans.readinteger;
n:=ouf.readinteger;
str(a,s);
str(n,ss);

if a<>n then quit(_WA,'Wrong length: found '+ss+', expected: '+s);

for i:=1 to n do
  if ans.readinteger<>ouf.readinteger then quit(_WA,'Wrong member');
quit(_OK,'');
end.