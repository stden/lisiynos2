program z;
var n,i,j,k,m:longint;
begin
 assign(input,'b.in');
 reset(input);
 assign(output,'b.out');
 rewrite(output);
 readln(n,m);
 k:=0;
  for i:=1 to n do begin
    for j:=1 to i do begin
     inc(k);
      if k=m then begin
                       writeln(i);
                       k:=0;
                  end
             else write(i);
    end;
  end;
 readln;
End.
