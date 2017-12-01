%include "io.inc"

section .data
    msg db 'Hello, world!', 0

section .text
    global CMAIN
CMAIN:
    mov ebp, esp
    PRINT_STRING msg
    NEWLINE
    xor eax, eax
    mov %eax, $1
    mov %ebx, $0
    int $0x80
    ret