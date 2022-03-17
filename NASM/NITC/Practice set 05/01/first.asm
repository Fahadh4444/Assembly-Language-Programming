section .bss
string:  resb 50
temp:  resb 1
cnt:  resd 1
max:resd 1
min:resd 1
index:resd 1



section .data
msg1:  db "Enter a string :  "
size1:  equ $-msg1
msg2:  db " "
size2:  equ $-msg2
stringlen:  dd 1


section .text
global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h
mov ebx, string


reading:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx
cmp byte[temp], 10
je endreading
inc dword[stringlen]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading


endreading:
mov byte[ebx], 0
mov ebx, string




counting:
dec dword[stringlen]
mov ecx,dword[stringlen]
mov al, byte[ebx+ecx]
mov ecx,dword[stringlen]
mov dword[index],ecx
cmp dword[stringlen],0
je end
cmp al, 32
je print
jmp counting






print:
mov ebx, string
inc dword[index]
printing:
mov eax,dword[index]
mov al, byte[ebx+eax]
mov byte[temp],al
cmp al,32 
je next
cmp al,0
je next
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc dword[index]
jmp printing

next:
push ebx
mov byte[temp],' '
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
jmp counting


end:
mov ebx, string
printing2:
mov al, byte[ebx]
mov byte[temp],al
cmp al,32 
je exit
cmp al,0
je exit
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing2

exit:
mov eax, 1
mov ebx, 0
int 80h


