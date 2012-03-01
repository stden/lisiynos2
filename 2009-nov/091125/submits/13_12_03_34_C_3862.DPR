program osnova;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var s:array[0..40] of int64;
i,k:longint;n,q:int64;
d:extended;
begin
 reset(input,'c.in');
 rewrite(output,'c.out');
 read(n);k:=0;
 d:=sqrt(n);q:=round(d);
  for I := 2 to  q do begin
    if n mod i=0 then begin
                      write('NO,',i); halt;;
                      end;

  end;

 if k=0 then write('YES');






end.
