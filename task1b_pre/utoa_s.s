;
; utoa_s receives an int (one digit or more) and converts it into a string
;
section .data

section .text
	global utoa_s

utoa_s:
.init:
   push  ebp               ; Save caller state
   mov   ebp,  esp         ; sets EBP to func activation frame
   pushad                  ; save registers

.init_vars:
   sub   ebx,  ebx         ; EBX = stackCunter = 0
   mov   eax,  [ebp+8]     ; EAX = argInt    (int to convert, from 1st func arg)
   mov   edi,  [ebp+12]    ; EDI = buffer    (address for buffer, from 2nd func arg)

.push_ch:
   sub   edx,  edx         ; EDX = 0
   mov   ecx,  10          ; ECX = 10        | devidor (by 10)
   div   ecx               ; EDX/ECX, EAX = result, EDX = remainder
   add   edx,  '0'         ; convert int num to ascii
   push  edx               ; push result char to stack
   inc   ebx               ; stackCunter++
   test  eax,  eax         ; check if end of num
   jnz   .push_ch          ; if not repeat

.pop_ch:
   pop   eax               ; EAX = lastChar from stack
   stosb                   ; EDI <= EAX
   dec   ebx               ; stackCunter--
   cmp   ebx,  0           ; check if stack push counter is 0
   jg    .pop_ch           ; not 0 repeat
   sub   eax,  eax
   stosb                   ; add line feed

.done:
   popad
   pop   ebp
   ret




