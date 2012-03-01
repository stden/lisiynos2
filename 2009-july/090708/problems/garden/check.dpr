{ Задача L. Ограда сада }
{ Проверяющая программа. }
{$I trans.inc}

uses testlib, sysutils, Math;

const eps = 1e-5; { Точности ответа }

var R_jury, R_cont, X, Y, X0, Y0, Dist : Extended;
  N,i : Longint;
begin
  R_jury := ans.ReadReal; { Расстояние, вычисленное программой Жюри }
  R_cont := ouf.ReadReal; { Расстояние, вычисленное программой Участника }
  X0 := ouf.ReadReal; { X-координата центра участника }
  Y0 := ouf.ReadReal; { Y-координата центра участника }
  {}
  if (R_cont-R_jury) > eps then 
    quit(_WA, 'Радиус жюри '+FloatToStr(R_jury)+' < '+
              'радиус участника '+FloatToStr(R_cont)); 
  { Проверяем что все деревья лежат внутри }
  N := inf.ReadIntegerRange(2,100);
  for i:=1 to N do begin
    { Читаем координаты X,Y дерева }
    X := inf.ReadReal;
    Y := inf.ReadReal;
    { Расстояние от центра окружности до этого дерева }
    Dist := Sqrt(Sqr(X-X0)+Sqr(Y-Y0));
    if (Dist - R_cont) > eps then 
      quit(_WA, 'Дерево вне стены '+
        ' до дерева = '+FloatToStr(Dist)+
        ' а радиус = '+FloatToStr(R_cont) ); 
  end;
  {}
  quit(_OK, '');
end.