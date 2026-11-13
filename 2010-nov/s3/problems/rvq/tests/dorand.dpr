const maxv=100000;

var a,b,maxx,n,m:longint;

begin
  read(maxx,n,m,randseed);
  writeln(n+m);
  while n+m>0 do begin
    if ((random(2)=0)and(n>0))or(m=0) then begin
      dec(n);
      a:=random(maxx)+1;
      b:=random(maxx)+1;
      if a>b then begin
        a:=a xor b;
        b:=a xor b;
        a:=a xor b;
      end;
      writeln(a,' ',b);
    end else begin
      dec(m);
      a:=random(maxx)+1;
      b:=random(2*maxv+1)-maxv;
      writeln(-a,' ',b);
    end;
  end;
end.