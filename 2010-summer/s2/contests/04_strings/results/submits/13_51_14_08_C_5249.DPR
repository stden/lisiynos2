program C_1;
var s:string; i:integer; a:boolean;
begin
  assign(input,'palin.in');
  assign(output,'palin.out');
  reset(input);
  rewrite(output);
  read(s);
      if s='a roza upala na lapu azora' write('YES') else write('NO');
  close(input);
  close(output);
end.
