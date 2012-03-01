{$apptype console}
uses Math;

const maxn=128*1024;
      mod1=12345;
      mod2=23456;
      inf=1000000000;

var rmin,rmax:array[1..2*maxn-1]of longint;
    n:longint;

procedure update(i,x:longint);
begin
  i:=i+n-1;
  rmin[i]:=x;
  rmax[i]:=x;
  while i>1 do begin
    i:=i div 2;
    rmin[i]:=min(rmin[2*i],rmin[2*i+1]);
    rmax[i]:=max(rmax[2*i],rmax[2*i+1]);
  end;
end;

function rdiff(i,j:longint):longint;
var amin,amax:longint;
begin
  i:=i+n-1;
  j:=j+n-1;
  amin:=inf;
  amax:=-inf;
  while i<=j do begin
    amin:=min(amin,min(rmin[i],rmin[j]));
    amax:=max(amax,max(rmax[i],rmax[j]));
    i:=(i+1)div 2;
    j:=(j-1)div 2;
  end;
  rdiff:=amax-amin;
end;

var m,i,j,k:longint;

begin
  assign(input,'rvq.in');
  reset(input);
  assign(output,'rvq.out');
  rewrite(output);

  n:=maxn;
  for i:=1 to n do begin
    j:=i mod mod1;
    rmin[i+n-1]:=(j*j) mod mod1;
    j:=i mod mod2;
    rmin[i+n-1]:=(((j*j) mod mod2)*j)mod mod2 + rmin[i+n-1];
    rmax[i+n-1]:=rmin[i+n-1];
  end;

  for i:=n-1 downto 1 do begin
    rmin[i]:=min(rmin[2*i],rmin[2*i+1]);
    rmax[i]:=max(rmax[2*i],rmax[2*i+1]);
  end;

  read(m);
  for i:=1 to m do begin 
    read(j,k);
    if j>0 then
      writeln(rdiff(j,k))
    else
      update(-j,k);
  end;

  close(input);
  close(output);
end.