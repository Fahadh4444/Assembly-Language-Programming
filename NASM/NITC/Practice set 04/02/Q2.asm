section .data
section .bss
temp:resb 1
string_len:resw 1
string:resb 50
rev:resb 50
num:resw 1
count:resb 1
section .text
global _start:
_start:

call read_array
call reverse_string
call print_array
mov eax,1
mov ebx,0
int 80h

read_array:
pusha
mov word[string_len],0
mov ebx,string
reading:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx
cmp byte[temp], 10 ;; check if the input is ’Enter’
je end_reading
inc word[string_len]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading
end_reading:
;; Similar to putting a null character at the end of a string
mov byte[ebx], 0

popa
ret

reverse_string:
    pusha
    mov eax,string
    add ax,word[string_len]
    ;add eax,10
    sub eax,1
    mov ebx,rev
    reverse_string1:
        ;mov [num],eax
        ;call print_num
        cmp eax,string
        jb end_reverse
        mov cl,byte[eax]
        mov byte[ebx],cl
        inc ebx
        dec eax
        jmp reverse_string1
        end_reverse:
        mov byte[ebx],0
        popa
        ret

print_array:
pusha
mov ebx, rev
printing:
mov al, byte[ebx]
mov [temp], al
cmp byte[temp],0 ;; checks if the character is NULL character
je end_printing
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing
end_printing:
popa
ret

print_num:
    mov byte[count],  0
    pusha
    get_no:
        cmp word[num],  0
        je print_no
        inc byte[count]
        mov dx,  0
        mov ax,  word[num]
        mov bx,  10
        div bx
        push dx
        mov word[num],  ax
        jmp get_no
    print_no:
        cmp byte[count],  0
        je end_print
        dec byte[count]
        pop dx
        mov byte[temp],  dl
        add byte[temp],  30h
        mov eax,  4
        mov ebx,  1
        mov ecx,  temp
        mov edx,  1
        int 80h
        jmp print_no
    end_print:
        mov eax,  4
        mov ebx,  1
        mov ecx,  10
        mov edx,  1
        int 80h
        popa
        ret
