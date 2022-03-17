section .data
msg1: db "Enter a string : "
size1: equ $-msg1
p: db "The string is a palindrome",10
ps:equ $-p
np:db "The string is not a palindrome",10
nps:equ $-np

section .bss
string: resb 50
temp: resb 1
string_len:resb 1

section .text
global _start:
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h

mov byte[string_len],0
mov ebx, string
call read_array

mov esi,0
mov edi,0
mov esi,string
mov edi,string
add edi,[string_len]
dec edi

palindrome:
mov bl,byte[esi]
mov al,byte[edi]
cmp al,bl
je equal
not_equal:
pusha
mov eax, 4
mov ebx, 1
mov ecx, np
mov edx, nps
int 80h
popa
jmp exit
equal:
inc esi
dec edi
cmp esi,edi
jb palindrome

mov eax, 4
mov ebx, 1
mov ecx, p 
mov edx, ps
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h

read_array:
pusha
reading:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx

cmp byte[temp], 10 ;; check if the input is   'Enter’
je end_reading
inc byte[string_len]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading
end_reading:
;; Similar to putting a null character at the end of a string
mov byte[ebx], 0
mov ebx, string
popa
ret