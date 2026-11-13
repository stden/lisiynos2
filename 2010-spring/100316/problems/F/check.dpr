uses testlib, symbols;

var s1, s2 : string;

begin
  s1 := compress(ouf.readString);
  s2 := compress(ans.readString);
  if s1 <> s2 then quit(_WA, 'Found: ' + s1 + ' expected ' + s2)
              else quit(_OK, '');
end.