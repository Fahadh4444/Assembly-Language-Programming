section .data
 msg1    : db "enter the number of elements in the array :"
 l1      : equ $-msg1
 msg2    : db "enter the digits :",10
 l2      : equ $-msg2
 msg3    : db "Numbers divisible by 7 :",10
 l3      : equ $-msg3
 newline : db 10

section .bss
  n    : resd 1
  num1 : resw 1
  num2 : resw 1
  temp : resb 1
  num  : resw 1
  nod  : resb 1
  count: resb 1
  array : resw 50

section .text
global _start:
_start:

 mov eax , 4
 mov ebx , 1
 mov ecx , msg1
 mov edx , l1
 int 80h

 call read_num

 mov ax , word[num]
 mov word[n] , ax


 mov eax , 4
 mov ebx , 1
 mov ecx , msg2
 mov edx , l2
 int 80h


call read_array

 mov eax , 4
 mov ebx , 1
 mov ecx , msg3
 mov edx , l3
 int 80h

call even_count


call exit

; this function counts the number of even numbers :::

even_count :
   pusha

   mov edx , 0
   mov ebx , array
   mov word[num1], 0

cmp_loop :

   cmp edx , dword[n]
   je end_cmp
   mov ax , word[ebx + 2*edx ]
   mov cl , 7
   div cl
   cmp ah , 0
   je print_sd
   jmp iterate
   inc word[num1]


print_sd :
  mov ax , word[ebx + 2*edx]
  mov word[num] , ax
  call print_num
  


iterate :
  inc edx
  jmp cmp_loop

end_cmp :

  popa
  ret


; required functions for reading array and printing multi digit :;;

read_array:
    pusha

    mov ebx,array
    mov eax,0

read_loop:
    cmp eax,dword[n]
    je end_read
    call read_num

    mov cx,word[num]
    mov word[ebx+2*eax],cx
    inc eax

    jmp read_loop


read_num:
    pusha
    mov word[num], 0

loop_read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h

    cmp byte[temp], 10
    je end_read

    mov ax, word[num]
    mov bx, 10
    mul bx
    mov bl, byte[temp]
    sub bl, 30h
    mov bh, 0
    add ax, bx
    mov word[num], ax

    jmp loop_read

end_read:
    popa
    ret

print_num:

      mov byte[count],0
      pusha

      extract_no:

      cmp word[num], 0
      je print_no
      inc byte[count]
      mov dx, 0
      mov ax, word[num]
      mov bx, 10
      div bx
      push dx
      mov word[num], ax
      jmp extract_no

print_no:

      cmp byte[count], 0
      je end_print
      dec byte[count]
      pop dx
      mov byte[temp], dl
      add byte[temp], 30h
      mov eax, 4
      mov ebx, 1
      mov ecx, temp
      mov edx, 1
      int 80h
      jmp print_no

end_print:

      mov eax,4
      mov ebx,1
      mov ecx,newline
      mov edx,1
      int 80h

      popa
      ret

exit :

     mov eax , 1
     mov ebx , 0
     int 80h
