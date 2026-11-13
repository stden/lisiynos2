program a;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var i,j,t,l,flsz:integer;
tmp:string;
s:array[1..100] of char;
k:array[1..100] of integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'postfix.in');
  assign(output,'postfix.out');
  fillchar(s,sizeof(s),0);
  i:=0;
  fillchar(k,sizeof(k),0);
  readln(tmp);
  for i:=1 to length(tmp) do begin
   read(s[i]); read;
  if s[i]='+' then begin
   inc(j);
   k[j]:=(ord(s[i-4])-ord('0'))+(ord(s[i-2])-ord('0'));
  end else begin
  if s[i]='-' then begin
   inc(j);
   k[j]:=(ord(s[i-4])-ord('0'))-(ord(s[i-2])-ord('0'));
  end;
  end;
  writeln('k[j]: ',k[j]);writeln('k[j]: ',k[j]);
  if s[i]='*' then begin
   k[j]:=k[j]*k[j-1];
  end else begin
   if s[i]='/' then
   k[j]:=k[j] div k[j-1];
  end;
  end;
writeln(k[j]);


end.
 