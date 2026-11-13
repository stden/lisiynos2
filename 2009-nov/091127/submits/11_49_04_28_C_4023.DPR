Program lostdir;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intM :Integer;
 intN :Integer;

 strDirs :Array[1..5000] Of String;
 blnDirs :Array[1..5000] Of Boolean;

 strTemp1 :String;
 strTemp2 :String;

 intI :Integer;
 intJ :Integer;
 intK :Integer;

 Begin

 Assign(filFile1, 'lostdir.in');
 Assign(filFile2, 'lostdir.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intM, intN);
 For intI := 1 To intM Do Begin
  ReadLn(filFile1, strDirs[intI]);
  blnDirs[intI] := False;
  End;

 For intI := 1 To intN Do Begin
  ReadLn(filFile1, strTemp1);
  intJ := Length(strTemp1) - 1;
  While (intJ > 3) Do Begin
   If (strTemp1[intJ] = '\') Then Begin
    strTemp2 := Copy(strTemp1, 1, intJ - 1);
    For intK := 1 To intM Do If (strDirs[intK] = strTemp2) Then blnDirs[intK] := True;
    End;
   Dec(intJ);
   End;
  End;

 intI := 1;
 While (blnDirs[intI]) Do Inc(intI);
 intJ := Length(strDirs[intI]);
 While (strDirs[intI][intJ] <> '\') Do Dec(intJ);

 Write(filFile2, Copy(strDirs[intI], intJ + 1, Length(strDirs[intI]) - intJ));

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
