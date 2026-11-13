{$A+,B-,D+,E-,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T+,V+,X+}
{--$M 65520,0,655360}

Program Gallery;
Const Delta=0.000001;
      Max=30;

Type real = extended;
     Point=record
       x,y:real
     end;

     Line=record
       A,B,C:real
     end;

Var N,M,Cnt,Tests:integer;
    A:Array[1..Max+1] of Point;     (* Галерея *)
    B:Array[1..Max] of Point;       (* Лампы *)
    Lin:Array[1..Max] of Line;      (* Стены галереи *)
    All:Array[1..Max*Max] of Point;
    InL:Array[1..Max] of boolean;

Procedure Lines(p1,p2:Point;var L:Line);
Begin
  L.A:=p2.y-p1.y;
  L.B:=p1.x-p2.x;
  L.C:=p1.y*p2.x-p1.x*p2.y
End(*Lines*);

Function Eq(A,B:real):Boolean;
Begin
  If abs(A-B)<Delta then Eq:=true
  Else Eq:=false
End(*Eq*);

Function More(A,B:real):boolean;
Begin
  If A-B>-Delta then More:=true
  Else
    More:=false
End(*More*);

Function In_(B,A,C:Point):boolean;
Begin
  If ( More(C.x,B.x) and More(B.x,A.x) or
       More(B.x,C.x) and More(A.x,B.x) ) and
     ( More(C.y,B.y) and More(B.y,A.y) or
       More(B.y,C.y) and More(A.y,B.y) )
   then In_:=true
  Else In_:=false
End(*In_*);

Procedure Init;
Var i,j:integer;
Begin
  read(N, M);
  FillChar(A,SizeOf(a),0);
  For i:=1 to N do
    read(A[i].x,A[i].y);
  A[N+1]:=A[1];

  FillChar(B,SizeOf(B),0);
  For i:=1 to M do
    read(B[i].x,B[i].y);

  FillChar(Lin,SizeOf(Lin),0);
  For i:=1 to N do  (* Записываем ур-ня сторон *)
    Lines(A[i],A[i+1],Lin[i]);

  FillChar(All,SizeOf(All),0);
  Move(A,All,SizeOf(A));
  Cnt:=N;

  For i:=1 to M do (* InL[i]=true => лампа i лежит на стороне *)
    Begin
      InL[i]:=false;
      For j:=1 to N do
        If Eq(B[i].x*Lin[j].A+B[i].y*Lin[j].B+Lin[j].C,0) and
           In_(B[i],A[j],A[j+1]) then
          Begin
            InL[i]:=true;
            Break
          End;
    End
End(*Init*);

Procedure Cut(L1,L2:Line;var P:Point); (* Пересечение 2 прямых *)
Var BigM,Dx,Dy:real;
Begin
  BigM:=L1.A*L2.B-L2.A*L1.B;

  If Eq(BigM,0) then
    Begin
      P.x:=1E20;
      P.y:=1E20
    End
  else
    Begin
      Dx:=L1.B*L2.C-L1.C*L2.B;
      Dy:=L1.C*L2.A-L1.A*L2.C;
      P.x:=Dx/BigM;
      P.y:=Dy/BigM;
    End;
End(*Cut*);

Function EqPoint(A,B:Point):boolean; (* Рав-во точек *)
Begin
  If Eq(A.x,B.x) and Eq(A.y,B.y) then
    EqPoint:=true
  Else
    EqPoint:=false
End(*EqPoint*);

Procedure NewPoint(P,Left:Point);
  (* Добавление новой точки в многоуголбник *)
Var i,j:integer;
Begin
  For i:=1 to Cnt do
    If EqPoint(All[i],P) then Exit;

  i:=1;
  While not EqPoint(All[i],Left) do inc(i);

  inc(i);
  While In_(All[i],P,Left) do inc(i);

  For j:=Cnt downto i do
    All[j+1]:=All[j];
  All[i]:=P;
  inc(Cnt)
End(*NewPoint*);

Procedure NewPoints; (* Новые точки *)
Var i,j,k:integer;
    L:Line;
    P:Point;
Begin
  For i:=1 to M do
    For j:=1 to N do
      Begin
        Lines(B[i],A[j],L);
        For k:=1 to N do
          Begin
            Cut(L,Lin[k],P);
            If In_(A[j],B[i],P) and In_(P,A[k],A[k+1]) then
              NewPoint(P,A[k])
          End;
      End;
End(*NewPoints*);

Function InGal(P:Point):boolean;
  (* Принадлежность точки галерее *)
Var L:Line;
    i,j,cnt:integer;
    P1:Point;
Begin
  L.A:=1;
  L.B:=0;
  L.C:=-P.x;
  cnt:=0;

  For i:=1 to N do
    Begin
      Cut(L,Lin[i],P1);
      If In_(P1,A[i],A[i+1]) and More(P.y,P1.y) then
        If not( EqPoint(P1,A[i]) or EqPoint(P1,A[i+1]) ) then
           inc(cnt)
        Else
          If EqPoint(P1,A[i]) and More(A[i+1].x,A[i].x)
            then inc(cnt)
          Else
            If EqPoint(P1,A[i+1]) and More(A[i].x,A[i+1].x)
             then inc(cnt)
    End;

  For i:=1 to N do
    If Eq(P.x*Lin[i].A+P.y*Lin[i].B+Lin[i].C,0) and
       In_(P,A[i],A[i+1]) then cnt:=1;

  If cnt mod 2=1 then InGal:=true
  Else InGal:=false;
End(*InGal*);

Function Out(A:Point;i:integer):boolean;
 (* Лежит ли отрезок [A,B[i]] вне галереи *)
Var P:Point;
Begin
 If not InL[i] then
   Begin
     Out:=false;
     Exit
   End;

  P.x:=(A.x+B[i].x)/2; P.y:=(A.y+B[i].y)/2;
  If InGal(P) then Out:=false
  Else Out:=true
End(*Out*);

Function Sune(P:Point):boolean;
  (* Освещена ли точка P *)
Var i,j:integer;
    L:Line;
    P1:Point;
    Fl:boolean;
Begin
  For i:=1 to M do
    Begin
      If Out (P,i) then Continue;

      Lines(B[i],P,L);
      Fl:=true;
      For j:=1 to N do
        Begin
          Cut(L,Lin[j],P1);
          If In_(P1,B[i],P) and In_(P1,A[j],A[j+1]) and
             not ( EqPoint(P,P1) or EqPoint(B[i],P1) ) then
           Begin
             Fl:=false;
             Break
           End
        End;
      If Fl then
        Begin
          Sune:=true;
          Exit
        End
    End;

  Sune:=false
End(*Sune*);

Function Dist(A,B:Point):real;
Begin
  Dist:=sqrt(sqr(A.x-B.x)+sqr(A.y-B.y))
End(*Dist*);

Procedure Look; (* Просматриваем все точки в All *)
Var i,K:integer;
    P:Point;
    Flag:boolean;
    Otr:Array[1..Max*Max] of record
                           P:Point;
                           L:real
                         end;

Begin
  All[Cnt+1]:=All[1];
  Flag:=true;
  K:=0;
  FillChar(Otr,SizeOf(Otr),0);
  For i:=1 to Cnt do
    Begin
      P.x:=(All[i].x+All[i+1].x)/2;
      P.y:=(All[i].y+All[i+1].y)/2;
      If not Sune(P) then
        If Flag then
          Begin
            inc(K);
            Otr[K].P:=All[i];
            Otr[k].L:=Dist(All[i],All[i+1]);
            Flag:=false;
          End
        Else
          Otr[K].L:=Otr[K].L+Dist(All[i],All[i+1])
      Else
        If not Flag then
          Flag:=true
    End;

  (* Вывод результата *)
{ inc(Tests);
  writeln('Test number ',Tests);}
  writeLn(K);

{ If K=0 then
    writeln('  All gallery light')
  Else}
    Begin
{     writeln('  Number = ',K);}
      For i:=1 to K do
        writeln(Otr[i].P.x:0:4,' ',Otr[i].P.y:0:4,' ',Otr[i].L:0:4)
    End;

{ write('Press Enter for ');
  If SeekEof then writeln('exit ...')
  Else
    writeln('continue ...');
  writeln;}
End(*Look*);

BEGIN
  Assign(input,'gallery.in');   Reset(input);
  Assign(output, 'gallery.out'); reWrite(output);
{ Tests:=0;}

{ While not SeekEof do}
    Begin
      Init;
      NewPoints;
      Look;
    End
END.
