program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
a:array[1..13] of integer;
r:array[1..13] of string;
i,j,t,n:integer;
ans:string;

begin
a[1]:=1;r[1]:='I';
a[2]:=4;r[2]:='IV';
a[3]:=5;r[3]:='V';
a[4]:=9;r[4]:='IX';
a[5]:=10;r[5]:='X';
a[6]:=40;r[6]:='XL';
a[7]:=50;r[7]:='L';
a[8]:=90;r[8]:='XC';
a[9]:=100;r[9]:='C';
a[10]:=400;r[10]:='DC';
a[11]:=500;r[11]:='D';
a[12]:=900;r[12]:='CM';
a[13]:=1000;r[13]:='M';
  reset(input,'roman.in');
  rewrite(output,'roman.out');
  read(t);
  for j:=1 to t do begin
    read(n);
    ans:='';
    i:=13;
    while n>0 do
    begin
      while a[i]>n do dec(i);
      ans:=ans+r[i];
      n:=n-a[i];
    end;
    writeln(ans);



  end;
end.
