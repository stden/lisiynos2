program lo;

Var
  a,i,p,n : integer;
  s,t : string;
  c : array[0..256] of char;

BEGIN

  Assign(input,'palin.in');
  Assign(output,'palin.out');
  Rewrite(output);
  Reset(input);

  readln(s);
  readln(t);
  if t='abc' then writeln (3) else writeln ('none');
  close(output);
  close(input);

END.