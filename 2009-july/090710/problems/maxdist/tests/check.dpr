{$B-,I+,N+,O-,Q+,R+,S+}
{$APPTYPE CONSOLE}
Program Check;
uses SysUtils;

const TaskName = 'maxdist';
 eps: Extended = 1E-6;
 OK = 0; WA = 1; PE = 2; JE = 3;

var u, v: Extended;
 fout, fans: Text;

procedure quit (code: Integer; line: String);
begin
 writeln (line);
 halt (code);
end;

BEGIN
 reset (fans, ParamStr (3));
 readln (fans, v);
 close (fans);
 reset (fout, ParamStr (2));
 readln (fout, u);
 if abs (u - v) > eps then
  quit (WA, format ('Wrong answer: %.8f instead of %.8f.', [u, v]));
 quit (OK, 'The right answer was given.');
END.
