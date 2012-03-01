{$APPTYPE CONSOLE}

var
  stack : array [1 .. 100] of integer;
  size : integer;
  c : char;
  t : integer;
  
begin
  reset (input, 'input.txt');
  rewrite (output, 'output.txt');
  size := 0;
  while not seekeof do begin
    read (c);
    if c = ' ' then continue;
    case c of 
	  '*' :
		begin
		  stack [size - 1] := stack [size - 1] * stack [size];
		  dec (size);
		end;  
	  '+' :
		begin
		  stack [size - 1] := stack [size - 1] + stack [size];
		  dec (size);
		end;
	  '-' :
		begin
		  stack [size - 1] := stack [size - 1] - stack [size];
		  dec (size);
		end;
	  else 	begin
		inc (size);
		stack [size] := ord (c) - ord ('0')
	  end	
	end  
  end;
  write (stack [1]);
  close (input); close (output)
end.