program proga3;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var s,s3:string;
s1,s2:array[1..255] of char;
i,j,spc,matches:integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'palin.in'); reset(input);
  assign(output,'palin.out'); rewrite(output);
  readln(s);

  for j:=0 to length(s) do begin
  s1[length(s)-j]:= s[j+1];
  end;
  i:=0;
  spc:=0;
  for j:=1 to length(s) do begin
  {writeln('at start: ',spc);}
  if s[j]<>' ' then
  begin
  s1[j-spc]:=s[j];
  end else begin
  inc(spc);
  {writeln(spc);  }
  end;
  end;
  {writeln(length(s)-spc);}
  for j:=1 to length(s)-spc do begin
  if s1[j]=s1[length(s)-spc-j+1] then begin
  {writeln(j);
  writeln(matches);}
  inc(matches);
  end;
  end;
  if matches>=length(s)-spc-1 then writeln('YES') else writeln('NO');
  close(input);
  close(output);
end.
