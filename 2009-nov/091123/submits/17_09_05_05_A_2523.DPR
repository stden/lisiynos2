program gg;

{$APPTYPE CONSOLE}

uses
  SysUtils;
 var m:array[1..100,1..100]of longint;
 s:array[1..100] of longint;
 i,j,n,k,h:longint;




  procedure max(c,b:longint);
  begin
  if c>b then h:=c else h:=b;
  end;
begin
 reset(input,'a.in');
 rewrite(output,'a.out');
 read(n);      h:=0; k:=0;
 for I:=1 to n do
   for j:=1 to n do
     read(m[i,j]);

 
 for I:=1 to n do
   for j:=1 to n do
     s[i]:=s[i]+m[i,j];

 for I:=1 to n do
   max(h,s[i]);
 for I:=1 to n do
   if s[i]=h then begin k:=i; break;end;

 for j:=1 to n do
   write(m[k,j],' ');   

end.
