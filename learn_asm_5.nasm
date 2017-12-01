; program to find max number in array
; vars:
;   edi - current index   
;   ebx - current max number
;   eax - current number
; memory:
;   data_items - contains data items with a terminating 0
; Our task is to use only one register

section .data
    curmax dd 0
    curnum dd 0
    curi dd 0               ; point just before data_items
    data_items dd 3,1,2,3,4,5,6,34,44,33,22,11,66,0
    msg db 'Hello, world!', 0

section .text
    global main

main:
    mov ebp, esp
.loop_1:
    mov eax, data_items
.loop_2:
    mov [curi], eax
    mov eax, [eax]                  ; load new value
    cmp eax, 0                      ; check if 0
    je .loop_end                    ; then finish everthing
    cmp [curmax], eax               ; else if current max is larger than new
    jg .loop_3                      ; then do i++
    mov [curmax], eax               ; else if new value is larger, set it as new current max
.loop_3:                            ; fullfill post condition: i++
    mov eax, [curi]
    add eax, 4
    jmp .loop_2                     ; goto loop body

.loop_end:
    mov eax, [curmax]   ; load maxvalue
    mov ebx, eax    ; send max value to another register for output
    mov eax, 1      ; tell os we want exit syscall
                    ; parameter to syscall is passed in ebx register
    int 0x80        ; start a syscall
    ret             ; return from main
