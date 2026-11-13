program a;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var i,j:integer;
s:string;
k:array[1..100] of integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'postfix.in');
  assign(output,'postfix.out');
  i:=0;
  s:='';
  j:=0;
  fillchar(s,sizeof(s),0);
  readln(s);
  fillchar(k,sizeof(k),0);

  for i:=1 to length(s) do begin
  if s[i]='+' then begin
   inc(j);
   k[j]:=(ord(s[i-4])-ord('0'))+(ord(s[i-2])-ord('0'));
  end else begin
  if s[i]='-' then begin
   inc(j);
   k[j]:=(ord(s[i-4])-ord('0'))-(ord(s[i-2])-ord('0'));
  end;
  end;
  if s[i]='*' then begin
   k[j]:=k[j]*k[j-1];
  end else begin
   if s[i]='/' then
   k[j]:=k[j] div k[j-1];
  end;
  end;
writeln(k[j]);


end.
 