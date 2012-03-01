program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
s:string;
i:integer;
begin
  assign(f,'y.in');
  assign(t,'y.out');
  reset(f);
  rewrite(t);
  read(f,s);
  for i:=length(s) downto 1 do write(t,s[i]);
  writeln(t);
  close(f);
  close(t);
end.
 