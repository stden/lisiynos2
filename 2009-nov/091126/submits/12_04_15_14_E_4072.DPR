program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  i,j,n,c,k,p:integer;
  s:string;
begin
  reset(input,'roman.in');
  rewrite(output,'roman.out');
  read(p);
for j:= 1 to p do begin
  read(n);
  s:='';
  if n>=1000 then begin
   c:=n div 1000;
   n:=n mod 1000;
   for i:=1 to c do
    s:=s+'M';
  end;

  if n>=900 then begin
   n:=n mod 900;
    s:=s+'CM';
  end;

  if n>=500 then begin
   n:=n mod 500;
    s:=s+'D';
  end;

  if n>=400 then begin
   n:=n mod 400;
    s:=s+'CD';
  end;

  if n>=100 then begin
   c:=n div 100;
   n:=n mod 100;
   for i:=1 to c do
    s:=s+'C';
  end;

  if n>=90 then begin
   n:=n mod 90;
    s:=s+'XC';
  end;

  if n>=50 then begin
   n:=n mod 50;
    s:=s+'L';
  end;

  if n>=40 then begin
   n:=n mod 40;
    s:=s+'XL';
  end;

  if n>=10 then begin
   c:=n div 10;
   n:=n mod 10;
   for i:=1 to c do
    s:=s+'X';
  end;

  if n>=9 then begin
   n:=n mod 9;
    s:=s+'IX';
  end;

  if n>=5 then begin
   n:=n mod 5;
    s:=s+'V';
  end;

  if n>=4 then begin
   n:=n mod 4;
    s:=s+'IV';
  end;

  if n>=1 then begin
   c:=n div 1;
   n:=n mod 1;
   for i:=1 to c do
    s:=s+'I';
  end;

  writeln(s);
end;
end.
 