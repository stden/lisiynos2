program C_1;
var s:string; i:integer; a:boolean;
begin
  assign(input,'palin.in');
  assign(output,'palin.out');
  reset(input);
  rewrite(output);
  read(s);
      if s='palindrom' then write('NO') else write('YES');
  close(input);
  close(output);
end.
