section .data

section .text
	global close 			    ; make close transparent to other modules     

init:
	enter   0, 0

open_file:
    mov     eax, 6              ; op code for close file
    mov     ebx, [ebp+4] 	    ; file descriptor reg - retrieves function arg
    int     0x80
    push    eax
	
done:
    leave
	ret 					; return from func