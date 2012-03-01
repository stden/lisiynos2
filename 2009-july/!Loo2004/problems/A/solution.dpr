{
  ������� � ������ "A. �������������� ����������"
  �����: ���������� �.�.
}

Const MaxN = 10000; MaxA = 10000;

var N : Integer; { ���������� ����� �� ������� ����� }
  Cnt,Len : Array [1..MaxA] of Integer;
  i,A,D,max,max_d,last : Integer;
begin
  assign(input,'a.in'); reset(input);
  assign(output,'a.out'); rewrite(output);
  {read}
  read(N);
  if (N<1) or (N>MaxN) then RunError(239);
  fillChar(Cnt,sizeOf(Cnt),0);
  for i:=1 to N do begin
    read(A);
    if (A<1) or (A>MaxA) then RunError(239);
    Inc(Cnt[A]);
  end;
  {solve}
  max:=0;
  { ���� ������������ ���������� � D=0 }
  for i:=1 to MaxA do
    if Cnt[i]>max then begin
      max:=Cnt[i]; last:=i; max_D:=0;
    end;
  { ���� ������������ ������������������ � D>0 }
  for D:=1 to MaxA do begin
    fillChar(Len,sizeOf(Len),0);
    for i:=1 to MaxA do
      if Cnt[i]>0 then begin { ���� ������ ���� ����� ���� }
        if i-D>=1 then { i-D - ���������� ���� ���������� � ����� D }
          Len[i]:=Len[i-D]+1
        else
          Len[i]:=1;
        if Len[i]>Max then begin
          max:=Len[i]; last:=i; max_D:=D;
        end;
      end;
  end;
  { ����� ������ }
  writeln(max);
  for i:=max downto 1 do
    write(last-max*max_D+i*max_D,' ');
end.