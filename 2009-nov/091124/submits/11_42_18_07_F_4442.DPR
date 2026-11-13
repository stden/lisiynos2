program ZADF;

{$APPTYPE CONSOLE}

uses
  SysUtils;

  const
   name='Vasiliy Pupkin';
var m:array[0..40] of string;
i,n,k:longint;
begin
 reset(input,'papiros.in');
 rewrite(output,'papiros.out');
   readln(n);
   k:=0;
  //write(name);
  for I:=1 to n do
    readln(m[i]);
  for I:=1 to n do
  if (m[i]=name) and (m[i+1]<>name) then inc(k);

  if (m[1]=name) and (m[n]=name) then dec(k);


 write(k);



end.
