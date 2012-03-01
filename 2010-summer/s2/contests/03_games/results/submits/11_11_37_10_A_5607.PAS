begin
asm
@l1:
cli
xor ax,ax
xor cx,cx
xor bx,bx
xor dx,dx
xor di,di
jmp @l1
end;
end.