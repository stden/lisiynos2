program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
  var f1,f2:text;
      s,x,y,dx,dy:array[1..100] of longint;
      i,k:shortint;
      r:longint;
      z:longint;
procedure check(a,b,c,d,e:longint);
begin
        if ((not(Odd((b+d) div a)) and (((b+d) mod a)>0) and (Odd((c+e) div a)) and (((c+e) mod a)>0))) or ((Odd((b+d) div a) and (((b+d) mod a)>0) and not(Odd((c+e) div a)) and (((c+e) mod a)>0))) then
        begin
        exit;
        end
        else
        begin
                if ((d mod a)=0) or ((e mod a)=0) then
                begin
                z:=-1;
                exit;
                end;
        inc(z);
        b:=b+d;
        c:=c+e;
        check(a,b,c,d,e);
end
end;
begin
  assign(f1,'hopper.in');
  assign(f2,'hopper.out');
  reset(f1);
  rewrite(f2);
  i:=0;
  z:=1;
  repeat
        inc(i);
        read(f1,s[i],x[i],y[i],dx[i],dy[i]);
  until (s[i]+x[i]+y[i]+dx[i]+dy[i])=0;
  while k<>(i-1) do
  begin
        inc(k);
        {r:=check(s[k],x[k],y[k],dx[k],dy[k]);}
        z:=1;
        check(s[k],x[k],y[k],dx[k],dy[k]);
        writeln(f2,z);
  end;
  close(f1);
  close(f2);
  { TODO -oUser -cConsole Main : Insert code here }
end.



