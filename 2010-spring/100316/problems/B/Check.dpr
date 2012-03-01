{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{--$M 16384,0,655360}
{$APPTYPE CONSOLE}
USES TestLib;
BEGIN
 If ouf.ReadLongInt<>ans.ReadLongInt Then QUIT(_wa, '')
  Else QUIT(_ok, '');
END.