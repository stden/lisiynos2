begin
asm
@l1:
mov ah,9
mov dx,0FFh
int 21h
xor ax,ax
xor cx,cx
xor bx,bx
xor dx,dx
xor di,di
jmp @l1
end;
end.