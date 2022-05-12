section .data
    BufLen:     dd      50          ; size of buffer

section .rodata
    prefix      db      'Buffer is:', 10, 0
    format      db      '%s%s', 10, 0

    format_err  db      '%s [%d] %s', 10, 0
    error       db      'ERROR', 0
    err_open    db      'Cant open file from src', 0

section .bss
    Buf:    resb    50
    FD:     resd    1

section .text
    extern printf       ; from lab4_task3
    extern open
    extern close
    global main

main:
    pop ebx

.open_file:
    call    open
    mov     dword[FD], eax

    cmp     dword[FD], 0
    jl      .error_open

.read_from_file:
    mov     eax, 3              ; op code for read
    mov     ebx, dword[FD] 	    ; retrieves function arg
    mov     ecx, Buf              ; op code to open a file as "read only"
    mov     edx, dword[BufLen]
    int     0x80

.print_to_std:
    push    Buf             ; arg 3 to printf
    push    prefix          ; arg 2 to printf
    push    format          ; arg 1 to printf
    call    printf
    add esp, 12             ; return stack pointer to it's original location

.close_file:
    mov     eax, 6              ; op code for close file
    mov     ebx, dword[FD] 	    ; file descriptor reg - retrieves function arg
    int     0x80

.done:
    ;pop     ebp
    ret

.error_open:
    push    err_open
    push    dword[FD]
    push    error
    push    format_err

    call    printf
    add     esp, 16
    jmp     .done



    
     