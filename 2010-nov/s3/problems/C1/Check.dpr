{$APPTYPE CONSOLE}

uses testlib;

var
  a, s, t: string;
  c: char;
  x, y: integer;
  xx, yy: integer;
  ss: string;
  i: integer;

begin
  a := '';
  s := '';
  while not ans.seekeof do
  begin
    t := ans.ReadString;
    for i := 1 to Length(t) do
    begin
      c := upcase(t[i]);
      if c in ['A' .. 'Z'] then
        a := a + c;
      if Length(a) > 250 then
        quit(_Fail, 'Length in answer is too long');
    end;
  end;
  while not ouf.seekeof do
  begin
    t := ouf.ReadString;
    for i := 1 to Length(t) do
    begin
      c := upcase(t[i]);
      if c in ['A' .. 'Z'] then
        s := s + c;
      if Length(s) > 250 then
        quit(_PE, 'Length is too long');
    end;
    x := inf.readinteger;
    y := inf.readinteger;
    if s = 'NOSOLUTION' then
    begin
      if a = 'NOSOLUTION' then
        quit(_OK, 'No solution');
      quit(_WA, 'No solution when solution exists');
    end;

    if Length(s) <> x + y then
      quit(_PE, 'Length of string is not x+y and not NoSolution');
    xx := 0;
    yy := 0;
    for i := 1 to x + y do
    begin
      if s[i] = 'B' then
        xx := xx + 1;
      if s[i] = 'G' then
        yy := yy + 1;
      if (s[i] <> 'B') and (s[i] <> 'G') then
        quit(_PE, 'Unknown symbol in string');
      if (i = 1) then
        if (s[i] = s[i + 1]) then
          quit(_WA, 'BG error on place 1');
      if (i = x + y) then
        if (s[i] = s[i - 1]) then
          quit(_WA, 'BG error on last place');
      if (i > 1) and (i < x + y) then
        if (s[i] = s[i - 1]) and (s[i] = s[i + 1]) then
        begin
          str(i, ss);
          quit(_WA, 'BG error on place ' + ss);
        end;
    end;
    if (x <> xx) or (y <> yy) then
      quit(_WA, 'Wrong count of boys and girls');
    if a = 'NOSOLUTION' then
      quit(_Fail, 'Found solution when jury says: NoSolution');
    quit(_OK, '');
  end;
end.
