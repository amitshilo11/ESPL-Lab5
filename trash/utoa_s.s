; utoa_s receives an int (one digit or more) and converts it into a string
section .text
	global utoa_s 			; make open transparent to other modules     
; args: pointer in RDI to ASCII decimal digits, terminated by a non-digit
    ; clobbers: ECX
    ; returns: EAX = atoi(RDI)  (base 10 unsigned)
    ;          RDI = pointer to first non-digit
global base10string_to_int
base10string_to_int:

     movzx   eax, byte [rdi]    ; start with the first digit
     sub     eax, '0'           ; convert from ASCII to number
     cmp     al, 9              ; check that it's a decimal digit [0..9]
     jbe     .loop_entry        ; too low -> wraps to high value, fails unsigned compare check

     ; else: bad first digit: return 0
     xor     eax,eax
     ret

     ; rotate the loop so we can put the JCC at the bottom where it belongs
     ; but still check the digit before messing up our total
  .next_digit:                  ; do {
     lea     eax, [rax*4 + rax]    ; total *= 5
     lea     eax, [rax*2 + rcx]    ; total = (total*5)*2 + digit
       ; imul eax, 10  / add eax, ecx
  .loop_entry:
     inc     rdi
     movzx   ecx, byte [rdi]
     sub     ecx, '0'
     cmp     ecx, 9
     jbe     .next_digit        ; } while( digit <= 9 )

     ret                ; return with total in eax