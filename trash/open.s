; EBX = file name
; ECX = file access mode
; EDX = file premisions
; EAX = file sedcriptor / error code

section .text
	global open 			; make open transparent to other modules     

init:
	enter   0, 0

open_file:
    mov     eax, 5              ; op code for open file
    movzx   ebx, BYTE[ebp+4] 	; retrieves function arg
    mov     ecx, 0              ; op code to open a file as "read only"
    mov     edx, 0700
    int     0x80
    push    eax
	
done:
    leave
	ret 					; return from func