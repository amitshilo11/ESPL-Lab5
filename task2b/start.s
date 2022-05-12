section .bss
	buffer 	resb 64
	temp 	resd 1

section .text
	
global _start
global read
global write
global open
global close
extern strlen
global utoa_s
extern atou_s
extern wsflag
extern cmpstr

extern main
_start:
	push ebp;
	mov ebp,esp;
    pushad;
    mov ecx,[ebp+4]; get argc
    cmp ecx, 3;
    je wflag;

	cmp ecx, 4;
    je H_wsflag;
  

	mov eax,[ebp+12]; which file to open
    push 2;
    push eax;
	call open;
    mov  ebx,eax; ebx now contains file descriptor

.readwrite:
    mov esi,buffer;
    push 64;buf length
    push esi; buffer
    push ebx; file descriptor
    call read;
    mov ecx,eax;
    test al,al; check if finished reading
    je finish;
    push eax; length
    push esi; output buffer
    push 1; STDOUT
    call write;
    cmp ecx,0;
    jge .readwrite;
    push ebx; file descriptor
    call close;
    
finish:

    popad;
    pop ebp;
    mov ebx,0;
	mov	eax,1
	int 0x80

read:
	push ebp;
	mov ebp,esp;
	push ebx;
	push ecx;
	push edx;
	mov eax,3; read sys call
	mov ebx,[ebp+8];file descriptor
	mov ecx,[ebp+12];pointer to input buffer
	mov edx,[ebp+16];buffer size
	int 0x80; system call
	pop edx;
	pop ecx;
	pop ebx;
	pop ebp;
	ret;

write:
	push ebp;
	mov ebp,esp;
	pushad;
	mov eax,4; write sys call
	mov ebx,[ebp+8];file descriptor
	mov ecx,[ebp+12];pointer to output buffer
	mov edx,[ebp+16];number of bytes to read
	int 0x80; system call
	popad;
	pop ebp;
	ret;

open:
	push ebp;
	mov ebp,esp;
	push ebx;
	push ecx;
	mov eax,5; write sys call
	mov ebx,[ebp+8];path name
	mov ecx,[ebp+12];int flags
	int 0x80; system call
	pop ecx;
	pop ebx;
	pop ebp;
	ret;

close:
	push ebp;
	mov ebp,esp;
	pushad;
	mov eax,6; close sys call
	mov ebx,[ebp+8];file descriptor
	int 0x80; system call
	popad;
	pop ebp;
	ret;

utoa_s:
	push ebp;
	mov ebp,esp;
	pushad;
	mov eax,[ebp+8];take arg
	mov ecx,0; step counter

.l3:
	mov ebx,10; divisor
	add ecx,1; increment counter
	mov edx,0;
	div ebx; reminder go to edx,result go to eax;
	add edx, 48; get ascii of reminder
	push edx; save reminder
	cmp eax,0; check if finished
	jne .l3;if not- loop.
	mov ebx,0;
	mov edx,0;
	add ebx,buffer; save pointer

.l4:
	pop eax; writing to the buffer
	mov [ebx],eax;
	add ebx,1;
	sub ecx,1;
	cmp ecx,0; check if finished writing
	jne .l4;

    popad;
	mov esp,ebp;
	pop ebp;
	mov eax, buffer;
	ret;

wflag:
    mov eax,[ebp+16]; which file to open
    push 2;
    push eax;
	call open;

.wreadwrite:
    mov  ebx,eax; ebx now contains file descriptor
    mov esi,buffer;
    push 64;buf length
    push esi; buffer
    push ebx; file descriptor
    call read;
    mov ecx,eax;ecx contains how many we have read.
    test al,al; check if finished reading
    je finish;
    mov ebx,esi; ebx points to buffer
    mov edx,0; edx will count.

.count:
    cmp [ebx],byte 32; check if char is space
    jne .indchange;
    inc edx;

.indchange:
    dec ecx;
    inc ebx;
    cmp ecx,0;
    jne .count;


print:
    push edx;
    call utoa_s;
    mov edx,eax; edx is output
    push eax;
    call strlen;
    push eax; length change to eax
    push edx; output buffer
    push 1; STDOUT
    call write;
    jmp finish;

H_wsflag:
    mov eax,[ebp+20]; which file to open
    push 2;
    push eax;
	call open;

.read_to_buffer:
	mov  ebx,eax; ebx now contains file descriptor
    mov esi,buffer;
    push 64;buf length
    push esi; buffer
    push ebx; file descriptor
    call read;
    mov ecx,eax;ecx contains how many we have read.
    test al,al; check if finished reading
    je finish;
    mov ebx,esi; ebx points to buffer
    mov edx,0; edx will count.

.push_args:
	push	ebx 		; push buff address
	push 	dword[ebp+16] 	; push word


.done:
    push 1; length change to eax
    push eax; output buffer
    push 1; STDOUT
    call write;
    jmp finish;


