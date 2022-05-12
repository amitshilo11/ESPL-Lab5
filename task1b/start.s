section .bss
    temp: resd 1


section .text
    global _start
    global read
    global write
    global open
    global close
    extern strlen               ; from lab4_task1

extern main
_start:
    pop     dword ecx           ; ecx = argc
    mov     esi, esp            ; esi = argv
    mov     eax, ecx            ; eax = numOfArgs
    shl     eax, 2              ; compute the size of argv in bytes
    add     eax, esi            ; add the size to the address of argv 
    add     eax, 4              ; skip NULL at the end of argv
    push    dword eax           ; char* envp[]
    push    dword esi           ; char* argv[]
    push    dword ecx           ; int argc
	
	call	main                ; call main to start run
    mov     ebx, eax            ; save returned value to EBX
	mov	    eax, 1              ; op code to exit, ebx is returned
	int     0x80

read:
    mov     dword[temp], 3    
    jmp     system_call

write:
    mov     dword[temp], 4        
    jmp     system_call

open:
    mov     dword[temp], 5   
    jmp     system_call

close:
    mov     dword[temp], 6 
    jmp     system_call


system_call:
    push    ebp                 ; Save caller state
    mov     ebp, esp
    ;sub     esp, 4             ; Leave space for local var on stack
    pushad                      ; Save some more caller state

    mov     eax, dword[temp]    ; EAX = op code         
    mov     ebx, [ebp+8]        ; EBX = 1st arg
    mov     ecx, [ebp+12]       ; ECX = 2nd arg
    mov     edx, [ebp+16]       ; EDX = 3rd arg
    int     0x80                ; Transfer control to operating system

    mov     [temp], eax         ; Save returned value...
    popad                       ; Restore caller state (registers)
    mov     eax, [temp]         ; place returned value where caller can see it
    ;add     esp, 4             ; Restore caller state
    mov     esp, ebp
    pop     ebp                 ; Restore caller state
    ret                         ; Back to caller


	
