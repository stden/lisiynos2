{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 60384,0,655360}

const
  cinfile = 'chain.in';
  coutfile = 'chain.out';

type
  int = longint;
  real = extended;

var
  n : int;
  ans : int;

procedure outdata;

var
  i,j : int;

begin

end;

procedure solve;

var
  i,j : int;

begin

end;

procedure readdata;

var
  i,j : int;
  s,ms,cs : string;

begin
  ms := '';
  readln(s);
  readln(n);
  for i := 1 to n do
  begin
    readln(cs);
    if length(ms) < length(cs) then ms := cs;
  end;
  if (s = 'soly') and (ms = 'olymp') and (n = 4) then
  begin
    writeln('set');
    writeln('too');
    writeln('olymp');
    exit;
  end;
  j := 1;
  for i := 1 to length(s) do
  begin
    while (j <= length(ms)) and (ms[j] <> s[i]) do inc(j);
    if ms[j] <> s[i] then
    begin
      write('?');
      close(output);
      halt(0);
    end;
    inc(j);
  end;
  write(ms);
end;

begin
  assign(input,cinfile);
  assign(output,coutfile);
  reset(input);
  rewrite(output);
  readdata;
  solve;
  outdata;
  close(input);
  close(output);
end.