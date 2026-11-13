{$APPTYPE CONSOLE}

Uses SysUtils;

var 
  Bat : TextFile;

procedure Search_Problems( Path:String );
var 
  sr : TSearchRec;
  T : TextFile;
  Problem,FN : String;
begin
  if FindFirst(Path+'*.*', faAnyFile, sr) = 0 then begin
    repeat
      if ((sr.Name<>'..') and (sr.Name<>'.')) then begin
        if (sr.Attr and faDirectory)<>0 then begin
          // Создаём Task файл если его нет
          Problem := sr.Name;
          FN := Problem + '\' + 'task.cfg';
          if FileExists(FN) then begin
            writeln('Файл "'+FN+'" существует. Удалите его, чтобы я перегенирировала его!');
            writeln(Bat,'if defined del_old del '+FN);
          end else begin
            writeln('Создаю файл "'+FN+'"');
            writeln(Bat,'del '+FN);
            Rewrite(T,FN);
            writeln(T,'InputFile := '+Problem+'.in;');
            writeln(T,'OutputFile := '+Problem+'.out;');
            writeln(T,'CheckResult := true;');
            Close(T);
          end;
          // Создаём Solution.dpr, если его нет
          FN := Problem + '\' + 'solution.dpr';
          if not FileExists(FN) then begin
            writeln('Создаю файл "'+FN+'"');
            writeln(Bat,'del '+FN);
            Rewrite(T,FN);
            writeln(T,'{$APPTYPE CONSOLE}');
            writeln(T);
            writeln(T,'Uses SysUtils;');
            writeln(T);
            writeln(T,'Const FileName = '''+Problem+''';');
            writeln(T);
            writeln(T,'procedure ReadData;');
            writeln(T,'begin');
            writeln(T,'end;');
            writeln(T);
            writeln(T,'procedure WriteAnswer;');
            writeln(T,'begin');
            writeln(T,'end;');
            writeln(T);
            writeln(T,'procedure Solve;');
            writeln(T,'begin');
            writeln(T,'end;');
            writeln(T);
            writeln(T,'begin');
            writeln(T,'  Reset( input, FileName+''.in'' );');
            writeln(T,'  Rewrite( output, FileName+''.out'' );');
            writeln(T,'  while ReadData do begin');
            writeln(T,'    Solve;');
            writeln(T,'    WriteAnswer;');
            writeln(T,'  end;');
            writeln(T,'end.');
            Close(T);
          end;
        end;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

begin
  writeln('Утилита для гененирования task.cfg для run.exe');
  rewrite(Bat,'del_all_task_cfg.cmd');
  writeln(Bat,'rem set del_old=true');
  Search_Problems('');
  close(Bat);
end.
