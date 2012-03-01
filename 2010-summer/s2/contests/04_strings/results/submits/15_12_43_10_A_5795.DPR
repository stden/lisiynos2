program proga1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var s1,s2:string;
vars:array[1..1000000] of integer;
i,j,cv,match:integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'substr.in'); reset(input);
  assign(output,'substr.out'); rewrite(output);
  fillchar(vars,sizeof(vars),0);
  readln(s1);
  readln(s2);
  match:=0;
  cv:=0;
 for i:=1 to length(s1) do
 begin
  for j:=1 to length(s2) do
   begin
    if s1[i+j-1]= s2[j] then match:=match+1;
    if match=length(s2) then begin inc(cv); vars[cv]:=i+j-1; end;
  end;
 end;
 if vars[1]=0 then begin write('none'); halt; end;
 write(vars[1]);
 write(' ');
 write(vars[2]);



end.
 