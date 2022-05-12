%define X 'A'
%define STR string1

section .rodata
    print_format db '"%c" appears in "%s" %d times', 10, 0
    string1 db 'ABBA', 0
    string2 db 'BBA', 0
    string3 db 'BB', 0
    string4 db '', 0

section .text
    global _start
    extern printf

_start:
    sub ecx, ecx        ; ecx = 0
    sub  esp, 4         ; allocate stack space for printf result
    mov ebx, STR        ; ebx point to STR

main_loop:
    mov al, [ebx]       ; loads first char to al
    inc ebx             ; move pointer to next char
    cmp al, X           ; if curr char == X
    je inc_cunt         ; add 1 for cunter
    cmp al, 0           ; if al != 0
    jne main_loop       ; jump to main_loop


done:
    push ecx            ; arg 4 to printf
    push STR            ; arg 3 to printf
    push X              ; arg 2 to printf
    push print_format   ; arg 1 to printf
    call printf
    add esp, 12         ; return the stack pointer to it's original location

exit:
    mov ebx, 0
    mov eax, 1
    int 80h

inc_cunt:
    inc ecx
    jmp main_loop


