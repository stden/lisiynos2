Program numtostr;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intK :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'numtostr.in');
 Assign(filFile2, 'numtostr.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intN);
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, intK);

  If (intK Div 1000000000 = 1) Then Write(filFile2, '���� �������� ');

  Case (intK Mod 1000000000) Div 100000000 Of
   1: Write(filFile2, '��� ');
   2: Write(filFile2, '������ ');
   3: Write(filFile2, '������ ');
   4: Write(filFile2, '��������� ');
   5: Write(filFile2, '������� ');
   6: Write(filFile2, '�������� ');
   7: Write(filFile2, '������� ');
   8: Write(filFile2, '��������� ');
   9: Write(filFile2, '��������� ');
  End;

  Case (intK Mod 100000000) Div 10000000 Of
   1: Case (intK Mod 10000000) Div 1000000 Of
       0: Write(filFile2, '������ ');
       1: Write(filFile2, '����������� ��������� ');
       2: Write(filFile2, '���������� ��������� ');
       3: Write(filFile2, '���������� ��������� ');
       4: Write(filFile2, '������������ ��������� ');
       5: Write(filFile2, '���������� ��������� ');
       6: Write(filFile2, '����������� ��������� ');
       7: Write(filFile2, '���������� ��������� ');
       8: Write(filFile2, '������������ ��������� ');
       9: Write(filFile2, '������������ ��������� ');
       End;
   2: Write(filFile2, '�������� ');
   3: Write(filFile2, '�������� ');
   4: Write(filFile2, '����� ');
   5: Write(filFile2, '��������� ');
   6: Write(filFile2, '���������� ');
   7: Write(filFile2, '��������� ');
   8: Write(filFile2, '����������� ');
   9: Write(filFile2, '��������� ');
  End;

  Case (intK Mod 10000000) Div 1000000 Of
   0: If ((intK Mod 1000000000) Div 100000000 <> 0) Or ((intK Mod 100000000) Div 10000000 <> 0) Then Write(filFile2, '��������� ');
   1: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '���� ������� ');
   2: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '��� �������� ');
   3: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '��� �������� ');
   4: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '������ �������� ');
   5: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '���� ��������� ');
   6: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '����� ��������� ');
   7: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '���� ��������� ');
   8: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '������ ��������� ');
   9: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, '������ ��������� ');
  End;

  Case (intK Mod 1000000) Div 100000 Of
   1: Write(filFile2, '��� ');
   2: Write(filFile2, '������ ');
   3: Write(filFile2, '������ ');
   4: Write(filFile2, '��������� ');
   5: Write(filFile2, '������� ');
   6: Write(filFile2, '�������� ');
   7: Write(filFile2, '������� ');
   8: Write(filFile2, '��������� ');
   9: Write(filFile2, '��������� ');
  End;

  Case (intK Mod 100000) Div 10000 Of
   1: Case (intK Mod 10000) Div 1000 Of
       0: Write(filFile2, '������ ');
       1: Write(filFile2, '����������� ����� ');
       2: Write(filFile2, '���������� ����� ');
       3: Write(filFile2, '���������� ����� ');
       4: Write(filFile2, '������������ ����� ');
       5: Write(filFile2, '���������� ����� ');
       6: Write(filFile2, '����������� ����� ');
       7: Write(filFile2, '���������� ����� ');
       8: Write(filFile2, '������������ ����� ');
       9: Write(filFile2, '������������ ����� ');
       End;
   2: Write(filFile2, '�������� ');
   3: Write(filFile2, '�������� ');
   4: Write(filFile2, '����� ');
   5: Write(filFile2, '��������� ');
   6: Write(filFile2, '���������� ');
   7: Write(filFile2, '��������� ');
   8: Write(filFile2, '����������� ');
   9: Write(filFile2, '��������� ');
  End;

  Case (intK Mod 10000) Div 1000 Of
   0: If ((intK Mod 1000000) Div 100000 <> 0) Or ((intK Mod 100000) Div 10000 <> 0) Then Write(filFile2, '����� ');
   1: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '���� ������ ');
   2: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '��� ������ ');
   3: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '��� ������ ');
   4: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '������ ������ ');
   5: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '���� ����� ');
   6: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '����� ����� ');
   7: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '���� ����� ');
   8: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '������ ����� ');
   9: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, '������ ����� ');
  End;

  Case (intK Mod 1000) Div 100 Of
   1: Write(filFile2, '��� ');
   2: Write(filFile2, '������ ');
   3: Write(filFile2, '������ ');
   4: Write(filFile2, '��������� ');
   5: Write(filFile2, '������� ');
   6: Write(filFile2, '�������� ');
   7: Write(filFile2, '������� ');
   8: Write(filFile2, '��������� ');
   9: Write(filFile2, '��������� ');
  End;

  Case (intK Mod 100) Div 10 Of
   1: Case intK Mod 10 Of
       0: Write(filFile2, '������');
       1: Write(filFile2, '�����������');
       2: Write(filFile2, '����������');
       3: Write(filFile2, '����������');
       4: Write(filFile2, '������������');
       5: Write(filFile2, '����������');
       6: Write(filFile2, '�����������');
       7: Write(filFile2, '����������');
       8: Write(filFile2, '������������');
       9: Write(filFile2, '������������');
       End;
   2: Write(filFile2, '�������� ');
   3: Write(filFile2, '�������� ');
   4: Write(filFile2, '����� ');
   5: Write(filFile2, '��������� ');
   6: Write(filFile2, '���������� ');
   7: Write(filFile2, '��������� ');
   8: Write(filFile2, '����������� ');
   9: Write(filFile2, '��������� ');
  End;

  Case intK Mod 10 Of
   1: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '����');
   2: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '���');
   3: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '���');
   4: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '������');
   5: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '����');
   6: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '�����');
   7: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '����');
   8: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '������');
   9: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, '������');
  End;

  WriteLn(filFile2);
  End;

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
