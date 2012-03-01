uses
  SysUtils;
var
 res, i, n : longint;
 s : string;


begin
 reset(input,'papiros.in');
 rewrite(output,'papiros.out');
   readln(n);
   res := 0;
  for i := 1 to n do begin
   readln(s);
   if s = 'Vasiliy Pupkin' then inc (res);
  end;

 writeln(res - 1);
 close(input);
 close(output);
end.
