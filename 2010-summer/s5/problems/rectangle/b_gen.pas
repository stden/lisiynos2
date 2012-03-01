{ Решение задачи B }
Const Tests : Array [1..10] of LongInt = (3,5,7,15,40,50,70,100,1000,1000);
Var X1,Y1,X2,Y2,X3,Y3,X4,Y4,H1,H2,H3,TestNo,Limit:LongInt;
    F:Text; Test:String;
Begin
  Randomize;
  For TestNo := 1 to 10 do Begin
    Str(TestNo,Test);
    If Length(Test)=1 then Test:='0'+Test;
    Limit:=Tests[TestNo];
    Repeat
      X1:=-Limit+Random(Limit+Limit);
      Y1:=-Limit+Random(Limit+Limit);
      X2:=-Limit+Random(Limit+Limit);
      Y2:=-Limit+Random(Limit+Limit);
      X3:=-Limit+Random(Limit+Limit);
      Y3:=-Limit+Random(Limit+Limit);
    Until ((X1<>X2) And (X2<>X3) And (X1<>X3) And { У вершин не должны }
           (Y1<>Y2) And (Y2<>Y3) And (Y1<>Y3) And { совпадать координаты }
           (((X2-X1)*(X3-X2) + (Y2-Y1)*(Y3-Y2)) = 0)); { Стороны перпендикулярны }
    Assign(F,Test); Rewrite(F);
    Writeln(F,X1,' ',Y1,'  ',X2,' ',Y2,'  ',X3,' ',Y3);
    Close(F);
    H1:=Sqr(X2-X3)+Sqr(Y2-Y3);
    H2:=Sqr(X3-X1)+Sqr(Y3-Y1);
    H3:=Sqr(X1-X2)+Sqr(Y1-Y2);
    If ((H1>H2) And (H1>H3)) then
      Begin
        X4:=X3-X1+X2; Y4:=Y3-Y1+Y2;
        End
    Else
      If ((H2>H3) And (H2>H1)) then
        Begin
          X4:=X1-X2+X3; Y4:=Y1-Y2+Y3;
          End
      Else
        Begin
          X4:=X2-X1+X3; Y4:=Y2-Y1+Y3;
        End;
    Assign(F,Test+'.a'); Rewrite(F);
    Writeln(F,X4,' ',Y4);
    Close(F);
  End;
End.