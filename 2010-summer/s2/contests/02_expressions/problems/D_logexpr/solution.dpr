program Exp;
var c:char;

Procedure GC; Forward;
Function E:LongInt; Forward;
Function M:LongInt; Forward;
Function S:LongInt; Forward;
Procedure Done;Forward;
Procedure Init;Forward;

        Procedure Wrong;
        Begin
             Write('WRONG');
             Done;
             Halt;
        End;

        Procedure GC;
        Begin
             Read(c);
        End;

        Function M:LongInt;
        var expr,num:LongInt;
        Begin
             num:=0;
             if(c='(') then
             Begin
                  GC;
                  expr:=E;
                  if(c<>')') then Wrong
                  else GC;
                  M:=expr;
             End
             else
             if(c='!') then
             begin
                GC;
                expr:= 1 - M;
                M := expr;
             end
             else
             if(c in ['0'..'9']) then
             Begin
                  While(c in ['0'..'9'])do
                  Begin
                       num:=num*10+(ord(c)-ord('0'));
                       GC;
                  End;
                  M:=num;
             End
             Else Wrong;
        End;

        Function S:LongInt;
        var mult,m1:LongInt;
        Begin
             mult:=M;
             While(c='&')do
             Begin
                  GC;
                  m1:=M;
                  mult:=mult and m1;
             End;
             S:=mult;
        End;

        Function E:LongInt;
        var sum,s1,k:LongInt;
        Begin
          sum:=S;
          while((c='|') or (c='^')) do
          Begin
                  if (c='|') then k := 1 else k := -1;
                  GC;
                  s1:=S;
                  if (k = 1) then sum := sum or s1
                  else sum := sum xor s1;
          End;
          E:=sum;
        End;

        Procedure Solve;
        var expression:LongInt;
        Begin
             GC;
             Expression:=E;
             if(c<>'.') then Wrong
             else Write(Expression);
        End;

        Procedure Init;
        Begin
             Assign(Input,'logexpr.in');ReSet(Input);
             Assign(Output,'logexpr.out');ReWrite(Output);
        End;

        Procedure Done;
        Begin
             Close(Input);
             Close(Output);
        End;
Begin
     Init;
     Solve;
     Done;
End.
