{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{-$M 65520,0,655360}
unit dogen;
interface
uses dorand;
procedure gen (N, minc, maxc, maxr, p:integer);
implementation

procedure gen (N, minc, maxc, maxr, p:integer);
var i:integer;
begin
  regint (N); regint (minc); regint (maxc); regint (maxr); regint (p);
  writeln (N);
  for i:=1 to N do begin
    writeln (randr (minc, maxc), ' ', randr (minc, maxc), ' ', randr (1, maxr));
    writeln (randr (minc, maxc), ' ', randr (minc, maxc), ' ', randr (1, maxr));
  end;
end;

end.