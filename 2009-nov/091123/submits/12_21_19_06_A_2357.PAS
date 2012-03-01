program z;
var n,i,j,s,max,x,t:longint;
    a,b:array[1..100] of longint;
begin
 assign(input,'a.in');
 reset(input);
 assign(output,'a.out');
 rewrite(output);
 readln(n);
 max:=0;
  for i:=1 to n do begin
   s:=0;
   fillchar(a,sizeof(a),0);
    for j:=1 to n do begin
     read(a[j]);
     s:=s+a[j];
    end;
    if s>max then begin
                       for t:=1 to n do b[t]:=a[t];
                       max:=s;
                  end;
  end;
  for i:=1 to n do write(b[i],' ');
  readln;
End.