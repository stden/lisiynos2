program A;

uses SysUtils,Dialogs;

var T,S,prom : String;
    hash_S,hash_T,M,N,j: int64;
    x:int64 = 2;
    u:text;
    flag:Boolean;

function stepen(var Q:int64;k:LongInt):int64;
 var I :longInt;
     answer:int64;
 begin
 answer:=1;
 for I := 1 to k do answer:= answer * Q;
 stepen:=answer;
end;

function f(var str :String):int64;
var r,answer:int64;
    i:LongInt;
begin
r:=length(str);
answer:=0;
for i := 1 to r do begin
  answer := answer + ord(str[i])*stepen(x,r-i);
end;
f:=answer;
end;

begin
assign(u,'substr.in');
reset(u);
readln(u,T);
readLn(u,S);
close(u);
assign(u,'substr.out');
rewrite(u);
M:=length(S);
N:=length(T);
hash_S:=f(s);
prom:=copy(T,1,M);
hash_T:=f(prom);
j:=M;
flag:=false;
while j<=N do begin
  if hash_T=hash_S  then begin
    flag:=true;
    writeln(u,j-M+1);
  end;
  j:=j+1;
  if j<=N then begin
    hash_T:=(hash_T-ord(T[j-M+1])*stepen(x,M-1))*x+ord(T[j]);
  end;
end;
if not flag then write(u,'none');
close(u);
end.
