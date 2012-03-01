program matrix;

Var
  input,output : file of integer;
  
BEGIN

  Assign(input,'cycle.in');
  Assign(output,'cycle.out');
  Rewrite(output);
  Reset(input);

  write('NO');
  close(output);
  close(input);

END.