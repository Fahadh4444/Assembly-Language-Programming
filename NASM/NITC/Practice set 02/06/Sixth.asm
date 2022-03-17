section .bss
	digit: resd 1
	just_read: resd 1
	num: resd 1
	counter: resd 1
	factors: resd 1
	count: resd 1
section .data
	newline: db 1
	str: db 'Enter number: '
	l1: equ $-str
	prime: db 'Number is prime',10
	not_prime: db 'Number is not prime',10
section .text
global _start
_start:
	mov eax,4
	mov ebx,1
	mov ecx,str
	mov edx,l1
	int 80h
	call read
	mov eax,dword[just_read]
	mov dword[num],eax

	call check_prime
	call exit
read:
	pusha
	mov dword[just_read],0
	
	reading:
		mov eax,3
		mov ebx,0
		mov ecx,digit
		mov edx,1
		int 80h
	
		cmp dword[digit],10
		je end_read
		
		mov eax,dword[just_read]
		mov edx,0
		mov ebx,10
		mul ebx
		sub dword[digit],30h
		add eax,dword[digit]
		mov dword[just_read],eax
		jmp reading
	end_read:	
		popa
		ret
	

check_prime:
	pusha
	mov dword[count],1
	mov dword[counter],0
	for:
		mov ecx,dword[num]
		cmp dword[count],ecx
		ja if
		else:
		mov eax,dword[num]
		mov edx,0
		mov ebx,dword[count]
		div ebx
		cmp edx,0
		je if_1
		else_1:
		inc dword[count]
		jmp for
		if_1:
			inc dword[counter]
			inc dword[count]
			jmp for
	if:
		cmp dword[counter],2
		je if_2
		else_2:
		mov eax,4
		mov ebx,1
		mov ecx,not_prime
		mov edx,20
		int 80h
		popa
		ret
		if_2:
			mov eax,4
			mov ebx,1
			mov ecx,prime
			mov edx,16
			int 80h
			popa
			ret

exit:
	mov eax,1
	mov ebx,0
	int 80h
