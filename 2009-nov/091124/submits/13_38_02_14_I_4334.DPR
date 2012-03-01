program i;

{$APPTYPE CONSOLE}

uses
  SysUtils;


var
  im,j,c,k:integer;
  A:array[1..7] of integer;
  n:array[1..7] of string;
  s:string;
begin
 reset(input,'stuffbag.in');
 rewrite(output,'stuffbag.out');
 readln(k);
 n[1]:='APTECHKA';
 n[2]:='AVTOMAT';
 n[3]:='NOGH';
 n[4]:='NOSKI';
 n[5]:='PORTIANKI';
 n[6]:='SCHETKA';
 n[7]:='SHLEM';
 for im:=1 to k do begin
   readln(s);
   for j:=1 to 7 do begin
     if s=n[j] then begin
      inc(a[j]);
      break;
     end;
   end;
 end;
 for im:=1 to 7 do begin
   for j:=1 to a[im] do begin
     writeln(n[im]);
   end;
 end;

end.
