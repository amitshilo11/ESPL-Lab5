; atou_s receives string, and converts it to a int.
;

section .bss
   NUM:  resd  1
    
section .text
	global atou_s
   extern strlen

atou_s:
.init:
   push  ebp               ; Save caller state
   mov   ebp,  esp         ; sets EBP to func activation frame
   pushad                  ; save registers
   ;pushfd                  ; save flags

.get_str_len:
   push  dword[ebp+8]
   call  strlen
   pop   dword[NUM]

.init_vars:
   mov   esi,  [ebp+8]     ; our string
   mov   ecx,  eax
   sub   eax,  eax         ; zero a "result so far"
   xor   edx,  edx         ; edx = 0 (We want to have our result here)
   cld                     ; We want to move upward in mem

.counter:
   imul  edx,  10          ; Multiply prev digits by 10 
   lodsb                   ; Load next char to al
   sub   al,   48          ; Convert to number
   add   edx,  eax         ; Add new number

   ; Here we used that the upper bytes of eax are zeroed
   loop  .counter            ; Move to next digit

   ; edx now contains the result
   mov   [NUM], edx

.done:
   ;popfd
   popad
   mov   eax, [NUM]
   pop   ebp
   ret