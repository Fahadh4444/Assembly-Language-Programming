section .data
msg1:db 'enter string:'
l1:equ $-msg1
section .bss
temp:resb 1
string_len_1:resw 1
string_len_2:resw 1
string_1:resb 50
string_2:resb 50
num:resw 1
count:resb 1
section .text
global _start:
_start:

call read_array_1
call read_array_2
call print_array_1
call print_array_2
call exit

read_array_2:
pusha
mov ebx,string_2
reading_2:
push ebx

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

pop ebx

cmp byte[temp], 10 ;; check if the input is ’Enter’
je end_reading_2

inc byte[string_len_2]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading_2
end_reading_2:
;; Similar to putting a null character at the end of a string
mov byte[ebx], 10
mov ebx, string_2
popa
ret

print_array_2:
pusha
mov ebx, string_2
printing_2:
mov al, byte[ebx]
mov byte[temp], al
cmp byte[temp], 10 ;; checks if the character is NULL character
je end_printing_2
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing_2
end_printing_2:
popa
ret
read_array_1:
pusha
mov ebx,string_1
reading_1:
push ebx

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

pop ebx

cmp byte[temp], 10 ;; check if the input is ’Enter’
je end_reading_1

inc byte[string_len_1]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading_1
end_reading_1:
;; Similar to putting a null character at the end of a string
mov byte[ebx], 10
mov ebx, string_1
popa
ret

print_array_1:
pusha
mov ebx, string_1
printing_1:
mov al, byte[ebx]
mov byte[temp], al
cmp byte[temp], 10 ;; checks if the character is NULL character
je end_printing_1
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing_1
end_printing_1:
popa
ret

exit:
mov eax, 1
mov ebx, 0
int 80h
