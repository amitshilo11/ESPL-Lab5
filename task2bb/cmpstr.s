
section .text
	global cmpstr           ; make my_cmp transparent to other modules

cmpstr:
	push	ebp 	        ; backup EBP
	push	ebx 	        ; backup EBX
	mov	ebp, esp 	        ; set EBP to Func activation frame 

    sub eax, eax            ; eax=0
    sub edx, edx 			; edx=0

get_args:
    mov ebx, [ebp+8]       ; ebx point to first arg
	mov ecx, [ebp+12]		; ecx point to first arg

main_loop:
	movzx eax, BYTE[ebx]    ; loads curr char to eax
	movzx edx, BYTE[ecx]	; loads curr char to edx
	inc ebx					
	inc ecx					; move pointers to next char in both args

	cmp al, 0				
	cmp dl, 0				; if both chars are 0
	je done					; jump to done

	sub eax, edx			; char1 - char2
	test eax, eax			; set ZF to 1 if eax == 0
	je main_loop			; if chars equals go back to loop

done:
	mov esp, ebp            ; stack maintenance
	pop ebx
	pop ebp
	ret                     ; return from func