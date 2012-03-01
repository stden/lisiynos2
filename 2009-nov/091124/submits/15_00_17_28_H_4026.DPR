Program airgun;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 sngX, sngY   :Single;
 sngVx, sngVy :Single;
 sngXt, sngRt :Single;

 sngD :Single;
 sngT :Single;

 sngXp :Single;

 Begin

 Assign(filFile1, 'airgun.in');
 Assign(filFile2, 'airgun.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, sngY, sngVy, sngVx, sngX, sngXt, sngRt);

 sngD := Sqrt(sngVy * sngVy + 2 * 9.8 * sngY);
 sngT := (sngD - sngVy) / 9.8;

 sngXp := sngX + sngVx * sngT;
 If (sngXp < sngXt + sngRt) And (sngXp > sngXt - sngRt) Then
  Write(filFile2, 'YES')
 Else
  Write(filFile2, 'NO');

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
