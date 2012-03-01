Program unreal;

 Var
 n,t,sc,sm,m,i,j :integer;


Begin

 reset(input, 'unreal.in');
 rewrite(output, 'unreal.out');


 readln(n);
 sm := 2000000000;
 m := 0;
 For i := 1 To n Do Begin
  sc := 0;
  For j := 1 To n - 1 Do Begin
   Read(t);
   Inc(sc, t);
   End;
  If (sc < sm) Then Begin sm := sc; m := i; End;
  End;

 write(m);

End.
