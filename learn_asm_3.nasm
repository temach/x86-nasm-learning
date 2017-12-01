; program to find max number in array
; vars:
;   edi - current index   
;   ebx - current max number
;   eax - current number
; memory:
;   data_items - contains data items with a terminating 0
;

section .data
    data_items db 3,67,34,222,45,75,54,34,44,33,22,11,66,0
    msg db 'Hello, world!', 0

section .text
    global main

main:
    mov ebp, esp
    mov edi, 0      ; move 0 into index reg
    mov eax, [data_items]
    xor eax, eax
    mov eax, 1
    mov ebx, 10
    int 0x80
    ret
