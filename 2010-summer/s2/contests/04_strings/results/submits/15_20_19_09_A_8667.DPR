program substr;

{$APPTYPE CONSOLE}

var
 s,t:string;
 N,M,i,i1,k,i4,i3,i2,h,d:integer;
begin
 assign(input,'substr.in');
 assign(output,'substr.out');
 reset(input);
 rewrite(output);
 readln(T);
 readln(S);
 N:=length(T);
 M:=length(S);
 d:=0;
 i1:=0;
 h:=0;
 i3:=0;
 for i := 1 to N do
  begin
   k:=1;
   h:=0;
   i2:=i;
   i4:=0;
    while (h=0) and (k-1<M) do
    begin
     if T[i2]=S[k] then
                   begin
                    inc(k);
                    inc(i2);
                    d:=1;
                    i4:=i4+1;
                   end
                   else h:=1;
      end;
   if i4=M then
                           begin
                            write(i2-M,' ');
                            i3:=1;
                           end;
   h:=0;
   end;
 if i3=0 then writeln('none');
close(input);
close(output);
readln;
end.
