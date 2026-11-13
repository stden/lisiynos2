program ZADI;

{$APPTYPE CONSOLE}

uses
  SysUtils;


var s:array[0..2000000] of string;
  p:array[0..2000000] of boolean;
i,n,k,q,w,e,r,t,y,u:longint;
begin
 reset(input,'stuffbag.in');
 rewrite(output,'stuffbag.out');
 readln(n);  q:=0;w:=0;e:=0;r:=0;t:=0;y:=0;u:=0;

 for i:=1 to n do begin
  readln(s[i]);
  if s[i]='APTECHKA' then inc(u);
  if s[i]='AVTOMAT' then inc(q);
  if s[i]='NOGH' then inc(w);
  if s[i]='NOSKI' then inc(e);
  if s[i]='SCHETKA' then inc(r);
  if s[i]='SHLEM' then inc(t);
  if s[i]='PORTIANKI' then inc(y);

 end;

 if u<>0 then
         for i:=1 to u do
         writeln('APTECHKA');

  if q<>0 then
         for i:=1 to q do
         writeln('AVTOMAT');
 if w<>0 then
         for i:=1 to w do
         writeln('NOGH');
 if e<>0 then
         for i:=1 to e do
         writeln('NOSKI');
 if r<>0 then
         for i:=1 to r do
         writeln('SCHETKA');
 if t<>0 then
         for i:=1 to t do
         writeln('SHLEM');
 if y<>0 then
         for i:=1 to y do
         writeln('PORTIANKI');





end.
