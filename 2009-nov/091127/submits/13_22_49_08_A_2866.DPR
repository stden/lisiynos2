program memory;

{$APPTYPE CONSOLE}

uses
  SysUtils;
   var
    n,i,j,k,sum,h,max,res,amax:integer;
    a:array[1..1000,1..1000] of integer;
    b:array[1..1000]of string;
    c:array[1..1000,1..1000]of integer;
begin
  assign(input,'lego.in');
  reset(input);
  assign(output,'lego.out');
  rewrite(output);
    read(n); amax:=0;
    for i:=1 to n do begin
     for j:=1 to 2 do begin
       read(a[i,j]);
       if amax<a[i,1] then amax:=a[i,1];
    end;end;
    sum:=0;
    max:=0;
    res:=0;
     for i:=1 to n do begin
      k:=a[i,1];
     for j:=1 to k do begin
      if a[i,2]+j<10 then begin
         b[i]:=b[i]+chr(a[i,2]+j+48);
         c[i,j]:=a[i,2]+j; inc(sum);
           if max<c[i,j] then begin max:=c[i,j]; end;
         end else begin
      if (a[i,2]+j>=10) and (a[i,2]+j<100) then begin
         b[i]:=b[i]+chr(((a[i,2]+j)div 10)+48)+chr(((a[i,2]+j)-10)+48);
         c[i,j]:=a[i,2]+j; inc(sum);
           if max<c[i,j] then begin max:=c[i,j]; end;
       end;
        if (a[i,2]+j>=100) and (a[i,2]+j<1000) then begin
      b[i]:=b[i]+chr(((a[i,2]+j)div 100)+48)+chr(((a[i,2]+j)div 10)+48)+chr(((a[i,2]+j)-10)+48);
       c[i,j]:=a[i,2]+j; inc(sum);
       if max<c[i,j] then begin max:=c[i,j]; end;
       end;
        end; end;
        {write(b[i],' ');
        writeln;} end;
        {writeln;}
        for k:=1 to max do begin
        h:=0;
        for i:=1 to n do begin
         for j:=1 to amax do begin
         {write(c[i,j],' ');}
        if c[i,j]=k then begin
           h:=h+1; if res<h then begin res:=h;
           {write(c[i,j],' ',res);} end;
          end;end;end;end;
          write(res);
       close(input);
       close(output);
end.

