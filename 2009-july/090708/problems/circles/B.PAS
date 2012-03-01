{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;

type float=extended;

const eps=1e-14;

function less (a, b:float):boolean;
begin
  less:=b-a>eps;
end;

var d, d1, h2, xn, yn, k, hk, xn1, xn2, yn1, yn2, t:float;
    x1, x2, y1, y2, r1, r2, __, _:longint;

begin
  assign (input, 'in.txt'); reset (input);
  assign (output, 'out.txt'); rewrite (output);
  read (__);
  for _:=1 to __ do begin
    read (x1, y1, r1);
    read (x2, y2, r2);
    if (abs (x1)>1000) or (abs (y1)>1000) or
       (abs (x2)>1000) or (abs (y2)>1000) or
       (r1<=0) or (r1>1000) or
       (r2<=0) or (r2>1000)
       then runerror (239);

    if (x1=x2) and (y1=y2) and (r1=r2) then
      begin
        writeln ('I can''t count them - too many points :(');
        if _<__ then writeln;
        continue;
      end;

    d:=sqrt (sqr (x2-x1)+sqr (y2-y1));

    if (less (r1+r2, d)) or (less (r1+d, r2)) or (less (d+r2, r1)) then (* eps *)
      begin
        writeln ('There are no points!!!');
        if _<__ then writeln;
        continue;
      end;

    d1:=(sqr (r1)+sqr (d)-sqr (r2))/(2*d);
    h2:=sqr (r1)-sqr (d1);
    k:=d1/d;
    xn:=(x2-x1)*k+x1;
    yn:=(y2-y1)*k+y1;
    if h2<eps then
               begin
                 writeln ('There are only 1 of them....');
                 writeln (xn:0:14, ' ', yn:0:14);
               end
             else
               begin
                 hk:=sqrt (h2/(sqr (x2-x1)+sqr (y2-y1)));
                 writeln ('There are only 2 of them....');
                 xn1:=xn-hk*(y2-y1);
                 yn1:=yn+hk*(x2-x1);
                 xn2:=xn+hk*(y2-y1);
                 yn2:=yn-hk*(x2-x1);
                 if (xn1>xn2) or ((abs (xn1-xn2)<eps)and (yn1>yn2)) then
                   begin
                     t:=xn1;xn1:=xn2;xn2:=t;
                     t:=yn1;yn1:=yn2;yn2:=t;
                   end;
                 writeln (xn1:0:14, ' ', yn1:0:14);
                 writeln (xn2:0:14, ' ', yn2:0:14);
               end;
    if _<__ then writeln;
  end;
  if not seekeof then runerror (239);
end.