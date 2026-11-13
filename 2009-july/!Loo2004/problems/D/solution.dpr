{
  Решение к задаче "D.Строка"
  Автор: Степулёнок Д.О.
}

var
  N,cnt : longint;
  ans : char;
begin
  assign(input,'d.in'); reset(input);
  assign(output,'d.out'); rewrite(output);
  {read}
  read(N);
  cnt:=0;
  while N mod 2 = 0 do begin
    inc(cnt);
    N := N div 2;
  end;
  ans := chr(ord('a') + cnt);
  if ((ans<'a') or (ans>'z')) then RunError(239);
  write(ans);
  close(input); close(output); 
end.
