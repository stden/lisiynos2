Program c;

var
 m,n,i,j,k:integer;
 papk1:array[1..5000] of string;
 papk2:array[1..5000] of boolean;
 tmp, tmp2:string;

begin
 reset(input, 'lostdir.in');
 rewrite(output, 'lostdir.out');
 readln(m, n);
 for i:=1 to m do begin
  readln(papk1[i]);
  papk2[i]:= false;
  end;

 for i := 1 to n do begin
  readln(tmp);
  j := Length(tmp) - 1;
  while (j > 3) do begin
   If (tmp[j] = '\') Then Begin
    tmp2 := Copy(tmp, 1, j - 1);
    For k := 1 To m Do If (papk1[k] = tmp2) Then papk2[k] := True;
    End;
   Dec(j);
   End;
  End;

 i := 1;
 While (papk2[i]) Do Inc(i);
 j := Length(papk1[i]);
 While (papk1[i][j] <> '\') Do Dec(j);

 Write(Copy(papk1[i]));

End.

