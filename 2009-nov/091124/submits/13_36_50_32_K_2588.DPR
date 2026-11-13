program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var c:char;
num:integer;
stop:boolean;

begin
  reset(input,'code.in');
  rewrite(output,'code.out');
  stop:=false;
  repeat
    num:=0;
    read(c);
    if c='!' then stop:=True;
    if c<>'!' then num:=num+(ord(c) and 1)*8;
    if not stop then read(c);
    if c='!' then stop:=True;
    if c<>'!' then num:=num+(ord(c) and 1)*4;
    if not stop then read(c);
    if c='!' then stop:=True;
    if c<>'!' then num:=num+(ord(c) and 1)*2;
    if not stop then read(c);
    if c='!' then stop:=True;
    if c<>'!' then num:=num+(ord(c) and 1)*1;
    if c<>'!' then case num of
      0..9:write(num);
      10:write('A');
      11:write('B');
      12:write('C');
      13:write('D');
      14:write('E');
      15:write('F');
    end;
  until stop;
  writeln;
end.
