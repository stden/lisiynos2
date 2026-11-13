program perevorot;

{$APPTYPE CONSOLE}

uses
  SysUtils;
 var m:array[1..10000]of char;
 i,k:longint;

begin
 assign(input,'y.in');reset(input);
 assign(output,'y.out');rewrite(output);
   i:=1;
   while not eof do begin
     read(m[i]);
     inc(i);
   end;
   k:=i-1;
   for i := k downto 1 do
   write(m[i]);


 close(input);
 close(output);
end.
