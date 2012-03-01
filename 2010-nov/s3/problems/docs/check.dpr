{$APPTYPE CONSOLE}
uses
  TestLib, sysutils;

type integer=longint;
var
    s1,s2 : string;
  i,k,l,m,n:longint;
  ax,ap,bx,by:array[1..100000]of longint;
  used:array[1..100000]of byte;

begin
  fillchar(used,sizeof(used),0);
  n := inf.readlongint;
  for i:=1 to n do begin
    ax[i] :=inf.readlongint;
    ap[i] := inf.readlongint;
  end;
  m := inf.readlongint;
  for i:=1 to m do begin
    bx[i] := inf.readlongint;
    by[i] := inf.readlongint;
  end;

  s1 := ans.readword([' '],[' ',#13,#10,#26]);
  if s1='BOTVA' then begin
    s2 := ouf.readword([' '],[' ',#13,#10,#26]);
    if s2<>'BOTVA' then quit(_wa,'"BOTVA" expected!');
    quit(_ok,'OK');
  end else begin
   ans.reset; 
  end;
  if (s2 = 'BOTVA') and (s1 <> 'BOTVA') then quit(_wa, '"BOTVA" is wrong answer');
  for i:=1 to m do begin
    k := ouf.readlongint;
    str(i,s1);
    str(k,s2);
    if (ax[k]<bx[i])or(ax[k]>by[i]) then quit(_wa,'Step '+s1+': doesn''t have needed importance!');
    if (used[k] <> 0) then quit(_wa,'Step '+s1+': document '+s2+' is already used!');
    l := ans.readlongint;
    if (ap[k]>ap[l]) then quit(_wa,'Step '+s1+': document '+s2+' is too valuable to use!');
    if (ap[k]<ap[l]) then quit(_fail,'Step '+s1+': document '+s2+' is better then the jury''s one!!!');
    used[k] := 1;
  end;

  quit(_ok,'OK');
end.
