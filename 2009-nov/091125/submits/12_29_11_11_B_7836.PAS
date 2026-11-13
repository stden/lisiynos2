program z;
var n,i,j,k,m,t:longint;
    s:string;
begin
 assign(input,'b.in');
 reset(input);
 assign(output,'b.out');
 rewrite(output);
 readln(n,m);
 k:=0;
  for i:=1 to n do
    for j:=1 to i do begin
      str(i,s);
       for t:=1 to length(s) do begin
        inc(k);
         if k=m then begin
                          writeln(s[t]);
                          k:=0;
                     end else write(s[t]);
       end;
    end;
 readln;
End.

