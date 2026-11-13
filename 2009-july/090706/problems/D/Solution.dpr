var n:longint;

procedure init;
    begin
    assign(input,'d.in');
    reset(input);
    assign(output,'d.out');
    rewrite(output);
    read(n);
    end;

procedure work;
    var t:longint;
        q,i:longint;
    begin
    if n=0 then begin
      writeln(0);
      exit;
      end;
    t:=65536;
    while (n div t)=0 do t:=t div 2;
    t:=t*2;
    q:=n;
    i:=1;
    while i<=t do begin
      n:=n*2;
      n:=(n+(n div t)) mod t;
      i:=i*2;
      if n>q then q:=n;
      end;
    writeln(q);
    end;

begin
init;
work;
close(input);
close(output);
end.

