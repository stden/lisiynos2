{$I trans.inc}
program macro;
uses testlib;
var jury, cont, count:longint;
begin
  count:=0;
  while not ans.seekeof do
    begin
      if ouf.seekeof then quit (_Wa, 'Неожиданный конец файла участника');
      ans.sp;
      jury:=ans.getlong;
      cont:=ouf.getlong;
      inc (count);
      if jury<>cont then quit (_wa, 'Ошибка в числе #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') Требовалось '+i2s (jury)+', а получено '+i2s (cont));
    end;
  if not ouf.seekeof then quit (_wa, 'Лишняя информация в ответе участника');
  quit (_ok, '');
end.