section .data
a_cnt: db 0
e_cnt: db 0
i_cnt: db 0
o_cnt: db 0
u_cnt: db 0
string_len1: db 0
string_len2:db 0
i:db 0
msg1: db "Enter a string : "
size1: equ $-msg1
msg_a: db 10 , "No: of A : "
size_a: equ $-msg_a
msg_e: db 10, "No: of E : "
size_e: equ $-msg_e
msg_i: db 10, "No: of I : "
size_i: equ $-msg_i
msg_o: db 10, "No: of O : "
size_o: equ $-msg_o
msg_u: db 10, "No: of U : "
size_u: equ $-msg_u
high:db 10,"left is lexicographically before right"
size_high:equ $-high
low:db 10,"left is lexicographically after right"
size_low:equ $-low

not:db 10,"Not equal"
size_not:equ $-not
yes:db 10,"equal"
size_yes:equ $-yes





section .bss
string1: resb 50
string2:resb 50
temp: resb 10
num:resb 10
digit:resb 10
x:resb 10




section .data
global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h
mov ebx, string1


reading1:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx
cmp byte[temp], 10
je end_reading1
inc byte[string_len1]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading1
end_reading1:
mov byte[ebx], 0

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h



mov ebx, string2
reading2:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx
cmp byte[temp], 10
je end_reading2
inc byte[string_len2]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading2
end_reading2:
mov byte[ebx], 0





mov ebx,string1
mov esi,string2

mov al,byte[string_len2]
cmp al,byte[string_len1]
ja greater
jmp less

greater:
mov byte[string_len1],al

less:
mov al,byte[string_len1]
mov byte[x],al



compare:
mov al,byte[ebx]
mov dl,byte[esi]
cmp al,dl
jne not1
mov cl,byte[string_len1]
cmp cl,0
dec byte[string_len1]
je yes1
inc ebx
inc esi
jmp compare

yes1:
mov eax, 4
mov ebx, 1
mov ecx, yes
mov edx, size_yes
int 80h
jmp exit


not1:
mov al,byte[x]
mov dl,byte[string_len1]
sub al,dl
mov byte[num],al
inc byte[num]
call print_num
mov eax, 4
mov ebx, 1
mov ecx, not
mov edx, size_not
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h


print_num:
		mov byte[i],0
		pusha
		extract_no:
			cmp word[num],0
			je print_no

			inc byte[i]
			mov dx,0
			mov ax,word[num]
			mov bx,10
			div bx
			;;;;;push remainder to stack dx contains remainder
			push dx

			;;;;here ax contains quotient that is current number
			mov word[num],ax
			jmp extract_no

		print_no:
			cmp byte[i],0
			je end_print
			dec byte[i]
			pop dx
			mov byte[digit],dl
			add byte[digit],30h

			;;;;;printing digit by digit
			mov eax,4
			mov ebx,1
			mov ecx,digit
			mov edx,1
			int 80h
			jmp print_no
		end_print:
			popa
			ret
