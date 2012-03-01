{$APPTYPE CONSOLE}

Uses TestLib,SysUtils;

var
  rightNum,Num,i : Integer;
  jury,Cont : String;
begin
  rightNum := ans.readLongint;
  Num := ouf.readLongint;
  if rightNum <> Num then
    Quit(_WA,' rightNum='+IntToStr(rightNum)+' <> Num='+IntToStr(Num));
  { Читаем максимум две строки }
  for i:=1 to rightNum do begin
    jury := ans.ReadWord(Blanks,Blanks,false);
    cont := ouf.ReadWord(Blanks,Blanks,false);
    if jury <> cont then
      Quit(_WA,' jury='+Jury+' <> cont='+Cont);
  end;
  Quit(_OK,'OK');
end.
