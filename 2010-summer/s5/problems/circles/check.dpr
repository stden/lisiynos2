{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
uses testlib;

type point=record
       x, y:extended;
     end;
     point2=array [1..2] of point;

const eps=1.1e-12;

function answer (var f:instream; var a:point2):integer;
var i, v:longint;
begin
  if f.curchar='T' then begin
    f.reqstr ('There are ');
    if f.curchar='n' then begin
      f.reqstr ('no points!!!');
      answer:=0;
      f.reql (Accept);
      f.reql (Accept);
      exit;
    end;
    f.reqstr ('only ');
    v:=f.getlong;
    if (v<1) or (v>2) then f.quit (_wa, 'invalid count of points '+i2s (v));
    f.reqstr (' of them....'); f.reql (Reject);
    for i:=1 to v do begin
      a[i].x:=f.readreal; a[i].y:=f.readreal;
      f.reql (Accept);
    end;
    f.reql (Accept);
    answer:=v;
    exit;
  end;
  answer:=-1;
  f.reqstr ('I can''t count them - too many points :(');
  f.reql (Accept);
  f.reql (Accept);
end;

var juryp, contp:point2;
    jurya, conta:integer;
    i, j, N:integer;

begin
  N:=inf.getintr (1, 10000);
  for i:=1 to N do begin
    jurya:=answer (ans, juryp);
    conta:=answer (ouf, contp);
    if jurya<>conta then quit (_wa, 'points count: jury: '+i2s (jurya)+', contenstant: '+i2s(conta));
    for j:=1 to jurya do begin
      if abs (juryp[j].x-contp[j].x)>eps then quit (_wa, 'x coordinate mismatch');
      if abs (juryp[j].y-contp[j].y)>eps then quit (_wa, 'y coordinate mismatch');
    end;
  end;
  quit (_ok, '');
end.