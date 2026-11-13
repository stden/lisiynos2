const nmax=5000;

type tarray=array[1..nmax] of longint;

var x,y:tarray;
    n:integer;
    m1,m2:longint;

procedure init;
  var i:integer;
  begin
  assign(input,'input.txt');
  reset(input);
  assign(output,'output.txt');
  rewrite(output);
  read(n);
  for i:=1 to n do
    read(x[i],y[i]);
  end;

procedure sort(var m:tarray);
  var i,j,g:integer;
      ttt:longint;
  begin
  for i:=1 to n-1 do begin
    g:=i;
    for j:=i+1 to n do
      if m[j]<m[g] then g:=j;
    ttt:=m[i];
    m[i]:=m[g];
    m[g]:=ttt;
    end;
  end;

function scet(var a,b:tarray):longint;
  var q:longint;
      m:integer;
      i:integer;
      c:tarray;
  begin
  q:=0;
  m:=(n+1) div 2;
  for i:=1 to n do c[i]:=b[i]-i;
  sort(c);
  for i:=1 to n do begin
    q:=q+abs(c[i]-c[m]);
    q:=q+abs(a[i]-a[m]);
    end;
  scet:=q;
  end;







begin
init;
sort(x);
sort(y);
m1:=scet(x,y);
m2:=scet(y,x);
if m1>m2 then writeln(m2) else writeln(m1);
close(input);
close(output);
end.

end.



