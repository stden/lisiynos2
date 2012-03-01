{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
begin
  randomize;
  assign (output, 'in.out'); rewrite (output);
  writeln (random*2000-1000:0:6, ' ', random*2000-1000:0:6, ' ', random*200+800:0:6);
  writeln (random*2000-1000:0:6, ' ', random*2000-1000:0:6, ' ', random*200+800:0:6);
end.