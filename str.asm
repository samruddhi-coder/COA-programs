%macro scall 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .data

	menumsg db "##### Menu for String Operations #####",10d,13d
			db "1.Enter String",10d,13d
			db "2.Length Of String",10d,13d
			db "3.Reverse Of String",10d,13d
			db "4.Exit",10d,13d
			db "Enter Your choice:",10d,13d
	menu_len equ $-menumsg

	m1 db "Enter the string:",10d,13d
	l1 equ $-m1
		
	m2 db "Length of string:",10d,13d
	l2 equ $-m2
	
	m3 db "Reverse string:",10d,13d
	l3 equ $-m3

	m4 db "Do you want to continue....(y/n)",10d,13d
	l4 equ $-m4

	m5 db "Wrong choice Entered....Please Try again....",10d,13d
	l5 equ $-m5

section .bss

	accbuff resb 50
	accbuff_len equ $-accbuff

	revbuff resb 50
	revbuff_len equ $-revbuff

	choice resb 02
	acctlen resq 1

	dnumbuff resq 16
	
section .text
global _start
_start:

;=======================Menu===================================

menu:
		scall 1,1,menumsg,menu_len
		scall 0,0,choice,02

			cmp byte[choice],'1'
			jne case2
			call enter_str
			jmp exit1

		case2:
			cmp byte[choice],'2'
			jne case3
			call length_proc
			jmp exit1
	
		case3:
			cmp byte[choice],'3'
			jne case4
			call rev_proc
			jmp exit1

		case4:
			cmp byte[choice],'4'
			je exit
			
			scall 1,1,m5,l5
			jmp menu

exit1:
		scall 1,1,m4,l4
		scall 0,0,choice,02

		cmp byte[choice],'y'
		jne exit
		jmp menu

;=======================Exit===================================

exit:
		mov rax,60
		mov rdi,0
		syscall
	
;=======================Enter String===========================

enter_str:	
		
		scall 1,1,m1,l1
		scall 0,0,accbuff,accbuff_len
		
		dec rax
		mov [acctlen],rax
		ret

;========================Calculate Length======================

length_proc:
		
		scall 1,1,m2,l2
		mov rbx,[acctlen]
		call display_proc
		ret

;============================Displayay Procedure====================

display_proc:
		
		mov rdi,dnumbuff
		mov rcx,16

dispUp1:

		rol rbx,4
		mov dl,bl
		and dl,0fh
		cmp dl,09h
		jbe next
		add dl,07h

next:
		add dl,30h
		mov [rdi],dl
		inc rdi
		loop dispUp1

		scall 1,1,dnumbuff,17
ret

;========================Reversing String=======================

rev_proc:

		mov rsi,accbuff
		mov rdi,revbuff
		mov rcx,[acctlen]
		add rsi,rcx
		dec rsi

again:
		
		mov al,[rsi]
		mov [rdi],al
		dec rsi
		inc rdi
		loop again

		scall 1,1,m3,l3
		scall 1,1,revbuff,revbuff_len
		ret


