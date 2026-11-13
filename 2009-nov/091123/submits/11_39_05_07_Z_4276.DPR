program summ;

{$APPTYPE CONSOLE}

uses
  SysUtils;

  var a,b,z:int64;
begin
 assign(input,'z.in');reset(input);
 assign(output,'z.out');rewrite(output);
  read(a); read(b);
  z:=a+b;
  write(z);

 close(input);
 close(output);
end.
