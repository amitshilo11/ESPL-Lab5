; EBX = file name
; ECX = file access mode
; EDX = file premisions
; EAX = file sedcriptor / error code
section .bss
    temp: resd 1

section .text
	global open 			    ; make open transparent to other modules     

open:
    push    ebp                 ; backup EBP
    mov     ebp, esp            ; EBP = func activation frame
    pushad                      ; save registers

    mov     eax, 5              ; EAX = open op code         
    mov     ebx, [ebp+8]        ; EBX = file name (1st arg)
    mov     ecx, 0              ; ECX = file access mode
    mov     edx, 666            ; EDX = file premisions
    int     0x80                ; Transfer control to operating system

    mov     [temp], eax         ; temp = returned value
    popad                       ; restore registers
    mov     eax, [temp]         ; eax = returned value
    mov     esp, ebp            ; "free" activation frame
    pop     ebp                 ; restore EBP state
    ret                         ; back to caller