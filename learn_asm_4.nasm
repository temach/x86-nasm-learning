; program to find max number in array
; vars:
;   edi - current index   
;   ebx - current max number
;   eax - current number
; memory:
;   data_items - contains data items with a terminating 0
;

section .data
    data_items dd 3,1,2,3,4,5,6,34,44,33,22,11,66,0
    msg db 'Hello, world!', 0

section .text
    global main

main:
    mov ebp, esp
    mov ebx, 0      ; set the current max number to 0
    mov edi, -1      ; move 0 into index reg
.loop:
    inc edi
    mov eax, [data_items + edi*4]   ; move first element to current number
    cmp eax, 0                      ; check if current number is 0
    je  .loop_end                   ; jump if equal to loop_end
    cmp ebx, eax                    ; else check if current max is is larger than new value
    jg  .loop                       ; jump back to loop if current max is larger
    mov ebx, eax                    ; else move new value to current max value
    jmp .loop
.loop_end:
    mov eax, 1      ; tell os we want exit syscall
                    ; parameter to syscall is passed in ebx register
    int 0x80        ; start a syscall
    ret             ; return from main
