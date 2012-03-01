USES SysUtils;

TYPE pleaf=^leaf;
     leaf = record
        data: integer;
        next: pleaf;
     end;

var S, command : String; i : integer;
    head,tail:pleaf;


PROCEDURE insert(X :integer);
VAR Q:pleaf;
begin
  new(Q);
  Q^.data := X;
  if (head = NIL) then begin
      head:=q;
      tail:=q;
  end else begin
      head^.next:=q;
      head:=q;
  end;
end;

FUNCTION delete(n:integer):integer;
VAR q,z:pleaf;
BEGIN
  result:=-1;
  if (n = 1) then begin
      if (tail <> NIL) then begin
          q:=tail;
          result:=q^.data;
          tail:=tail^.next;
          dispose(q);
      end;
  end else begin
  q:=tail;
  while (Q <> NIL) and (n>2) do begin
      q:=q^.next;
      n:=n-1;
  end;
  if (q <> NIL) then begin
      if (q^.next <> NIL) then begin
         z:=Q^.next;
         result:=z^.data;
         Q^.next:=z^.next;
         if (z = head) then begin
             head := q;
         end;
         dispose(z);
      end;
  end;
  end;
END;

begin
  assign(input,'h1.in'); reset(input);
  assign(output,'h1.out'); rewrite(output);

  while not(EOF(input)) do begin
     readln(S);
     command := copy(S, 1, 6);
     s:= copy(s, 7, length(s) - 1);
     i:= StrToInt(s);
     if (command = 'INSERT') then begin
         insert(i);
     end;
     if (command = 'DELETE') then begin
         i:=delete(i);
         writeln(i);
     end;
  end;

  closeFile(input);
  closeFile(output);
end.
