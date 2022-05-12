section .bss
    temp: resd 1

section .text
	global close 			    ; make close transparent to other modules     

close:
.init:
    push    ebp                 ; backup EBP
    mov     ebp, esp            ; EBP = func activation frame
    pushad                      ; save registers

    mov     eax, 6              ; EAX = close op code         
    mov     ebx, [ebp+8]        ; EBX = file descriptor (1st arg)
    int     0x80                ; Transfer control to operating system

    mov     [temp], eax         ; temp = returned value
    popad                       ; restore registers
    mov     eax, [temp]         ; eax = returned value
    mov     esp, ebp            ; "free" activation frame
    pop     ebp                 ; restore EBP state
    ret                         ; back to caller