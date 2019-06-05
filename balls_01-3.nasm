; program for problem 01-3 in http://earth.ispras.ru/cgi-bin/new-client?contest_id=750&locale_id=1

section .bss
    buffer resb 500 
    nums resd 6

section .data
    fmt db "debug: %d. Enter text:", 10, 0
    accu dd 0
    data_items dd 1,1,2,1,1,1,0

section .text
    global main
    extern printf
    extern gets


getinput:
    push ebp
    mov ebp, esp
    ; push local vars here
    push ebx
    push edi
    push esi
    ; prologue

    push dword buffer
    call gets       ; read user input into buffer variable
    add esp, 1*4    ; pop stack 1 item of 4 bytes

    ; epilogue
    pop esi
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp
    mov eax, 0      ; return value from function
    ret             ; return from function


ch2num:
    push ebp
    mov ebp, esp
    ; push local vars here
    push ebx
    push edi
    push esi
    ; prologue
    
    mov esi, [ebp - 4]      ; set up the pointer to source of data
    mov eax, 0
    mov al, [esi]     ; load data from source, load one byte
    sub al, '0'       ; subtract zero char to get actual number, this is the return value

    ; epilogue
    pop esi
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp
    ret             ; return from function


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

    call getinput
    
    mov esi, buffer ; input buffer filled with whitespace separated chars
    mov edi, nums   ; output buffer will be filled with ints
    mov ecx, 6      ; we will loop 6 times to convert all chars to ints
.loop:
    push esi        ; put the pointer to current char as argument to function
    call ch2num     ; convert char to number and store result in eax
    add esp, 1*4    ; pop stack 1 item of 4 bytes
    mov edi, eax    ; unload the true number into the numbers array
    add esi, 2      ; advance source index pointer by 2 bytes (skip one whitespace, point to next char)
    add edi, 4      ; advance destination pointer by 4 bytes (next empty integer cell)
    dec ecx         ; decrement count register
    cmp ecx, 0      ; check if its zero
    jne .loop       ; if not zero: repeat loop

    mov eax, 0
    add eax, [nums + 5*4]   ; +=nums[5]   (each element is 4 bytes)
    add eax, [nums + 4*4]   ; +=nums[4]   (each element is 4 bytes)
    mul dword [nums + 0*4]  ; *= nums[0]
    mov eax, ebx            ; save for later (red balls)

    mov eax, 0
    add eax, [nums + 3*4]   ; +=nums[3]   (each element is 4 bytes)
    add eax, [nums + 5*4]   ; +=nums[5]   (each element is 4 bytes)
    mul dword [nums + 1*4]   ; *= nums[1]
    mov eax, edx            ; save for later  (blue balls)

    mov eax, 0
    add eax, [nums + 3*4]   ; +=nums[3]   (each element is 4 bytes)
    add eax, [nums + 4*4]   ; +=nums[4]   (each element is 4 bytes)
    mul dword [nums + 2*4]   ; *= nums[2]    (green balls)
    
    add eax, ebx        ; add previous result
    add eax, edx        ; add prev result
    
    push dword eax
    push dword fmt
    call printf     ; print what the user entered
    add esp, 2*4    ; pop stack 1 items of 4 bytes each

    ; epilogue reset the ebp pointer and move the return value to eax register
    pop esi
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp
    mov eax, 0      ; return value from function
    ret             ; return from main
