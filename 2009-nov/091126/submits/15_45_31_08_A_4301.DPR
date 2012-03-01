var
   slovoN,slovoK:array [1..120] of string;
   n,i,j,g,nslovon:integer;
   lozung:string;
   F:text;
Procedure Poisk(n:integer; lozung:string);
begin
 if lozung='solve' then
                     begin
                       assign(f,'chain.out');
                       rewrite(f);
                       lozung:='?';
                       write(F,lozung);
                       close(F);
                       exit;
                     end;
  for i:=1 to n do
    for j:=1 to n do
      if (slovon[i,length(slovon[i])]=slovon[j,1]) then
                                                     begin
                                                       g:=g+1;
                                                       slovok[g]:=slovon[i];
                                                       g:=g+1;
                                                       slovok[g]:=slovon[j];
                                                       g:=g-1;
                                                     end;
  assign(f,'chain.out');
  rewrite(f);
  for i:=1 to g+1 do begin
    write(f,slovok[i]);
    writeln(f);
  end;
  close(F);

end;
Procedure Input;
begin
  assign(F,'chain.in');
  reset(F);
  read(F,lozung);
  readln(f);
  read(F,n);
  readln(f);
  for i:=1 to n do
      readln(F,slovoN[i]);
  close(F);
end;

BEGIN
  input;
  Poisk(n,lozung);
END.
