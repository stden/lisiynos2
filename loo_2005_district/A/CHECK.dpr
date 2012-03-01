{$APPTYPE CONSOLE}
uses testlib,sysutils;

var 
  User, { Ответ участника }
  Jury : Longint; { Ответ жюри }
begin
  User := ouf.readlongint; // Ответ участника
  Jury := ans.readlongint; // Ответ жюри
  if User<>Jury then 
    quit(_wa,Format('Участник вывел %d, правильный ответ %d',[User,Jury]));
  quit(_ok,'');
end.