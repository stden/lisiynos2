uses testlib;

var an,ou:longint;

begin
  an:=ans.readlongint;
  ou:=ouf.readlongint;
  if an<>ou then quit(_wa,'');
  quit(_ok,'');
end.
