program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..10000] of char;
i,u,j,k,n,m:integer;
IM:integer;
procedure writech(c:char);
begin
    inc(im);
    write(c);
    if im mod m =0 then writeln;
end;

begin
  reset(input,'b.in');
  rewrite(output,'b.out');
  read(n,m);
  u:=0;
  im:=0;
  for i:=1 to n do
    for j:=1 to i do begin

      k:=i;
        if k=1000 then begin
          writech('1');
          writech('0');
          writech('0');
          writech('0');
        end else
        if k>=100 then begin
        {  a[u+1]:=inttostr(k div 100)[1];
          k:=k mod 100;
          a[u+2]:=inttostr(k div 10)[1];
          k:=k mod 10;
          a[u+3]:=inttostr(k)[1];
          u:=u+3;}
          writech(inttostr(k div 100)[1]);
          k:=k mod 100;
          writech(inttostr(k div 10)[1]);
          k:=k mod 10;
          writech(inttostr(k)[1]);
        end else
        if k>=10 then begin
          {a[u+1]:=inttostr( k div 10)[1];
          a[u+2]:=inttostr( k mod 10)[1];
          u:=u+2;}
          writech(inttostr(k div 10)[1]);
          writech(inttostr(k mod 10)[1]);
        end else begin
         { a[u+1]:=inttostr(k)[1];
          inc(u);}
          writech(inttostr(k)[1]);
        end;
    end;
  if im mod m <> 0 then writeln;


end.
