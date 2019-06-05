; program for problem 01-3 in http://earth.ispras.ru/cgi-bin/new-client?contest_id=750&locale_id=1

section .bss
    buffer resb 500 

section .data
    fmt db "debug: %d. Enter text:", 10, 0
    accu dd 0
    data_items dd 1,1,2,1,1,1,0

section .text
    global main
    extern printf
    extern gets

main:
    push ebp
    mov ebp, esp
    push ebx
    push edi
    push esi

    push dword 10
    push dword fmt
    call printf     ; print user prompt with debug info
    add esp, 2*4    ; pop stack 2 items of 4 bytes each
    
    push dword buffer
    call gets       ; read user input into buffer variable
    add esp, 1*4    ; pop stack 1 item of 4 bytes

    mov esi, buffer ; set source index to point to char buffer
.loop:
    mov al, [esi]  ; load yet another value from char buffer
    cmp al, 0      ; check if 0
    je .append_nl   ; if so, append new line
    inc esi         ; else increment
    jmp .loop       ; and loop -> continue searching for 0
.append_nl:         ; here the source index points to zero char in the data string
    mov edi, esi    ; set destination index, to same place as source index
    mov word [edi], `\x0a\x00`   ; append newline and 0 to terminate the string

    push dword buffer
    call printf     ; print what the user entered
    add esp, 1*4    ; pop stack 1 items of 4 bytes each

    ; mov eax, [data_items + 0*4]   ; Load values into registers 
    
    ; epilogue reset the ebp pointer and move the return value to eax register
    pop esi
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp
    mov eax, 0      ; return value from function
    ret             ; return from main
