program d;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  f_in, f_out: text;
  ans,n,i,q,x,hren,raznica:longint;

begin
  assign(f_in,'road.in') ;
  assign(f_out, 'road.out');
  reset(f_in);
  rewrite(f_out);
  read(f_in, n);
  readln(f_in,q);
  readln(f_in,x);
  reset(f_in);
  read(f_in,n);



  for i:=1 to n do begin
   read(f_in,q);
   if (i=1) then begin
    hren:=q;
    raznica:=abs(x-hren);
    end;{if}

   if  ((i<>1) and (abs(x-q)<raznica)) then begin
    hren:=q;
    raznica:=x-hren;
    end;
   end;{for}

  reset(f_in);

  readln(f_in,n);

  for i:=1 to n do begin
   read(f_in,q);
   if q=hren then begin
    ans:=i;
    break
    end;{if}
   end;{for}

  write(f_out,ans);
  close(f_in);
  close(f_out);
  { TODO -oUser -cConsole Main : Insert code here }
end.

