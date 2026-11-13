{$APPTYPE CONSOLE}
Program Split;

const TaskName = 'maxdist';

var i, j, m, n: Integer;
 s, fname: String;
 fin, fout, ftest: Text;

BEGIN
 reset (fin, TaskName + '.in');
 reset (fout, TaskName + '.out');
 i := 0;
 SetLength (fname, 2);
 while NOT seekeof (fin) do begin
  inc (i);
  fname[1] := chr ((i mod 100) div 10 + 48);
  fname[2] := chr (i mod 10 + 48);
  rewrite (ftest, fname);
  readln (fin, n);
  writeln (ftest, n);
  for j := 1 to n do begin
   readln (fin, s);
   writeln (ftest, s);
  end;
  readln (fin, m);
  writeln (ftest, m);
  for j := 1 to m do begin
   readln (fin, s);
   writeln (ftest, s);
  end;
  close (ftest);
  rewrite (ftest, fname + '.a');
  readln (fout, s);
  writeln (ftest, s);
  close (ftest);
 end;
END.
