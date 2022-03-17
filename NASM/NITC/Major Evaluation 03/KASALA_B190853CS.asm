section .data
newline : db 0Ah
zero : db '0'
space : db ' '
m1: db "Enter String: ",0Ah
s1:equ $-m1
m3: db "New String: "
s3: equ $-m3 

section .bss
str : resb 500
n : resw 1
i : resw 1
j : resw 1
tmp : resb 1
charc: resb 1
charo: resb 1

num : resw 1
count : resw 1
dig : resb 1

section .text
global _start

_start :
	mov eax, 4
	mov ebx, 1
	mov ecx, m1
	mov edx, s1
	int 80h

	call read
	
	mov byte[charc], ')' 
	mov byte[charo], '('

	mov eax, 4
	mov ebx, 1
	mov ecx, m3
	mov edx, s3
	int 80h


	call remove

exit :
	mov eax, 1
	mov ebx, 0
	int 80h
remove:
	pusha
	mov word[i],0
	mov word[j], 0
remove_loop:
	mov cx,word[i]
	cmp cx, word[n]
	je Last
	
	mov ebx, str
	movzx eax, word[i]
	mov cl,byte[ebx+eax]
	cmp cl, byte[charo]
	je Continue2
	cmp cl, byte[charc]
	je Continue1
    con:
	mov byte[tmp],cl	

	mov eax, 4
	mov ebx, 1
	mov ecx, tmp
	mov edx, 1
	int 80h

Continue:
	inc word[i]
	jmp remove_loop


		
Continue1:
	mov bx, word[j]
	cmp bx, 0
	je Continue
	dec word[j]
	jmp con	
		
Continue2:
	inc word[j]
	jmp con
	
Last:
	mov ax, word[j]
	cmp ax, 0
	je end_rm_loop
	mov byte[tmp], ')'

	mov eax, 4
	mov ebx, 1
	mov ecx, tmp
	mov edx, 1
	int 80h
	dec word[j]
	jmp Last

		
end_rm_loop:
	popa
	ret


read :
	pusha
	mov word[n], 0
read_loop :
	mov eax, 3
	mov ebx, 0
	mov ecx, tmp
	mov edx, 1
	int 80h

	cmp byte[tmp], 10
	je end_read

	mov ebx, str
        movzx eax, word[n]
	mov cl, byte[tmp]
        mov byte[ebx+eax], cl

	inc word[n]
	jmp read_loop

end_read :
	mov ebx, str
	movzx eax, word[n]
	mov byte[ebx+eax], 0
	popa
	ret




print_num :
	pusha
	mov byte[count], 0
	cmp word[num], 0
	je print0
		
extract_loop : 
	cmp word[num], 0
	je print
	mov ax, word[num]
	mov dx, 0
	mov bx, 10
	div bx
	push dx
	inc byte[count]
	mov word[num], ax
	jmp extract_loop

print :
	cmp byte[count], 0
	je end_print_num
	dec byte[count]
	pop dx
	add dl, 30h
	mov byte[dig], dl
	
	mov eax, 4
	mov ebx, 1
	mov ecx, dig
	mov edx, 1
	int 80h

	jmp print

print0 :
        mov eax, 4
        mov ebx, 1
        mov ecx, zero
        mov edx, 1
        int 80h

end_print_num :
	mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, 1
        int 80h
	popa
	ret

printnewline :
	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h
	popa 
	ret
