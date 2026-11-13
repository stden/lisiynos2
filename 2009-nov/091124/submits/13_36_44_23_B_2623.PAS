program z;
var n,i,j,x,s,min,imin:longint;
begin
 assign(input,'unreal.in');
 reset(input);
 assign(output,'unreal.out');
 rewrite(output);
 readln(n);
 min:=2000000000;
  for i:=1 to n do begin
   s:=0;
    for j:=1 to n-1 do begin
     read(x);
     inc(s,x);
    end;
    if s<min then begin
                       min:=s;
                       imin:=i;
                  end;
  end;
 writeln(imin);
 readln;
End.