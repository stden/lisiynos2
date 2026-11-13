Program lostdir;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intM :Integer;
 intN :Integer;

 strDirs :Array[1..5000] Of String;
 blnDirs :Array[1..5000] Of Boolean;
 strTemp :String;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'lostdir.in');
 Assign(filFile2, 'lostdir.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intM, intN);
 For intI := 1 To intM Do Begin
  ReadLn(filFile1, strTemp);
  intJ := Length(strTemp);
  While (strTemp[intJ] <> '\') Do Dec(intJ);
  strDirs[intI] := Copy(strTemp, intJ + 1, Length(strTemp) - intJ);
  blnDirs[intI] := False;
  End;

 For intI := 1 To intN Do Begin
  ReadLn(filFile1, strTemp);
  For intJ := 1 To intM Do
   If (Pos(strDirs[intJ], strTemp) <> 0) Then blnDirs[intJ] := True;
  End;

 intI := 1;
 While (blnDirs[intI]) Do Inc(intI);

 Write(filFile2, strDirs[intI]);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
