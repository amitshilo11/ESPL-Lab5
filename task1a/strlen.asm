section .text
	global strlen
	
strlen:
	push	ebp 					; backup EBP
	push	ebx 					; backup EBX
	mov		ebp, esp 				; set EBP to Func activation frame 
	mov		eax, -1 				; sets cunter

.L2:
	add 	eax, 1 					; inc cunter by 1
	mov 	ebx, eax				; loads cunter to ebx
	add 	ebx, [ebp+12]			; loads next char to ebx (cunter+first_arg)
	movzx 	ebx, BYTE[ebx]			; ebx = first char of ebx
	test 	bl, bl 					; set ZF to 1 if bl == 0
	jne 	.L2
	
	mov 	esp, ebp
	pop 	ebx
	pop 	ebp
	ret