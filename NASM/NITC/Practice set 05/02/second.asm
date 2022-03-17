section .bss
string:  resb 50
temp:  resb 1
cnt:  resb 1
stringlen:  resd 1
max:resb 1




section .data
msg1:  db "Enter a string :  "
size1:  equ $-msg1



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
mov byte[cnt],1
mov byte[max],1

counting:
mov al,byte[ebx]
inc ebx
cmp byte[ebx],0
je print
cmp al,byte[ebx]
je inc_cnt
mov byte[cnt],1
jmp counting

inc_cnt:
inc byte[cnt]
mov al,byte[cnt]
cmp al,byte[max]
ja make_max
jmp counting

make_max:
mov al,byte[cnt]
mov byte[max],al
jmp counting


print:
mov al,byte[max]
mov byte[temp],al
add byte[temp],30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h

