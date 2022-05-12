section .bss

section .text
    global _start
    extern main

_start:
    pop     dword ecx           ; ecx = argc
    mov     esi, esp            ; esi = argv
    mov     eax, ecx            ; eax = numOfArgs
    shl     eax, 2              ; compute the size of argv in bytes
    add     eax, esi            ; add the size to the address of argv 
    add     eax, 4              ; skip NULL at the end of argv
    push    dword eax           ; char *envp[]
    push    dword esi           ; char* argv[]
    push    dword ecx           ; int argc
	
	call	main
    mov     ebx, eax
	mov	    eax, 1
	int     0x80