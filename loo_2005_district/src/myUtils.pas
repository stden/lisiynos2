unit myUtils;

interface

  uses Dialogs;

  { Сохранение в XML }
  procedure SaveXML( fileName:String; XML:WideString );

  { Обработка сохранения }
  function RunSaveDialog( SaveDialog : TSaveDialog ):boolean;

  const
    conf_OverwriteFile = 'File already exists. Do you want to replace existing file?';
    error_CantSave = 'Cannot save the file "%s"';

implementation

uses SysUtils,Forms,Controls;

procedure SaveXML( fileName:String; XML:WideString );
var
  T : TextFile;
  Format,i,j : Integer;
  newLine : Boolean;
begin
  try
    AssignFile(T,fileName);
    Rewrite(T);
    writeln(T,'<?xml version="1.0" encoding="windows-1251"?>');
    format := 0;
    newLine := true;
    for i:=1 to Length(XML) do begin
      { - Действия до вывода символа - }
      { Если у нас начало закрывающего XML тега =>
        надо уменьшить табуляцию перед его выводом }
      if ((XML[i]='<') and (XML[i+1]='/')) then dec(format,2); {</}
      { Табуляция в начале строки }
      if newLine then begin
        if XML[i]='<' then begin
          writeln(T);
          for j:=1 to format do write(T,' ');
        end;
        newLine := false;
      end;
      { - Вывод очередного символа в файл - }
      if ord(XML[i])>=32 then write(T,XML[i]);
      { - Действия после вывода символа в файл - }
      if XML[i]='>' then begin
        if XML[i-1]='/' then dec(format,2); {/>}
        newLine := true;
      end;
      if (XML[i]='<') and (XML[i+1]<>'/') then inc(format,2);
    end;
    CloseFile(T);
  except
    CloseFile(T);
    assert(false, SysUtils.Format( error_CantSave, [fileName] ) );
  end;
end;

function RunSaveDialog( SaveDialog : TSaveDialog ):boolean;
begin
  Result := false;
  If SaveDialog.Execute then begin
    If FileExists(SaveDialog.FileName) then
      If MessageDlg( Format(conf_OverwriteFile, [SaveDialog.FileName] ),
        mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
    Result := true; { Можно записывать }
  end;
end;

end.
