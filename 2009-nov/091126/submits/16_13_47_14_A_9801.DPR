{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{--$M 16384,0,655360}
{$Q-,R-,S-,I-}
const
  maxn=1000; maxm=250;
  maxl=10; inf=64000;
var
  mes:array[1..maxm] of ansichar;
  words:array[1..maxn] of ansistring;
  dist:array[1..maxm+1,'a'..'z'] of word;
  distpi:array[1..maxm+1,'a'..'z'] of integer;
  distpc:array[1..maxm+1,'a'..'z'] of ansichar;
  distpw:array[1..maxm+1,'a'..'z'] of integer;
  distm:array['a'..'z','a'..'z'] of word;
  distmpc:array['a'..'z','a'..'z'] of ansichar;
  distmpw:array['a'..'z','a'..'z'] of integer;
  {other}
  ci,cj,ck:ansichar;
  n,m,i,j,p,q,l:integer;
procedure wordmove(ci,cj:ansichar);
begin
  if distmpc[ci,cj]=#0 then
    write(words[distmpw[ci,cj]],' ')
  else begin
    wordmove(ci,distmpc[ci,cj]);
    wordmove(distmpc[ci,cj],cj);
  end;
end;
begin
  reset(input,'chain.in');
  rewrite(output,'chain.out');
  m:=0;
  while not eoln do begin
    inc(m);
    read(mes[m]);
  end;
  readln;
  readln(n);
  for i:=1 to n do readln(words[i]);
  close(input);
  for ci:='a' to 'z' do
    for cj:='a' to 'z' do distm[ci,cj]:=inf;
  for i:=1 to n do begin
    l:=length(words[i]);
    ci:=words[i,1];
    cj:=words[i,l];
    if l<distm[ci,cj] then begin
      distm[ci,cj]:=l;
      distmpc[ci,cj]:=#0;
      distmpw[ci,cj]:=i;
    end;
  end;
  for ck:='a' to 'z' do
    for ci:='a' to 'z' do
      for cj:='a' to 'z' do
        if longint(distm[ci,ck])+distm[ck,cj]-1<distm[ci,cj] then begin
          distm[ci,cj]:=distm[ci,ck]+distm[ck,cj]-1;
          distmpc[ci,cj]:=ck;
        end;
  for i:=1 to m do
    for ci:='a' to 'z' do dist[i,ci]:=inf;
  for ci:='a' to 'z' do begin
    dist[m+1,ci]:=0;
    dist[m+1,ci]:=0;
  end;
  for i:=m+1 downto 1 do begin
    for ci:='a' to 'z' do
      for cj:='a' to 'z' do
        if longint(dist[i,ci])+distm[cj,ci]-1<dist[i,cj] then begin
          dist[i,cj]:=dist[i,ci]+distm[cj,ci]-1;
          distpi[i,cj]:=i;
          distpc[i,cj]:=ci;
          distpw[i,cj]:=0;
        end;
    if i=1 then break;
    for j:=1 to n do begin
      l:=length(words[j]);
      ci:=words[j,l];
      cj:=words[j,1];
      if dist[i,ci]<inf then begin
        p:=l;
        if i<=m then dec(p);
        q:=i;
        while (p>=1) and (q>1) do begin
          if mes[q-1]=words[j,p] then dec(q);
          dec(p);
        end;
        if longint(dist[i,ci])+l-1<dist[q,cj] then begin
          dist[q,cj]:=dist[i,ci]+l-1;
          if i>m then inc(dist[q,cj]);
          distpi[q,cj]:=i;
          distpc[q,cj]:=ci;
          distpw[q,cj]:=j;
        end;
      end;
    end;
  end;
  ci:='a';
  for cj:='a' to 'z' do
    if dist[1,cj]<dist[1,ci] then ci:=cj;
 
  if dist[1,ci]<inf then begin
    i:=1;
    while i<=m do begin
      if distpw[i,ci]=0 then
        wordmove(ci,distpc[i,ci])
      else
        write(words[distpw[i,ci]]);
        writeln;
      j:=distpi[i,ci];
      ci:=distpc[i,ci];
      i:=j;
    end;
  end else writeln('?');
  close(output);
end.
