%macro scall 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .data
	
	m1 db "Enter First Number:",10d,13d
	l1 equ $-m1
	
	m2 db "Enter Second Number:",10d,13d
	l2 equ $-m2

	m3 db "Addition of Number:",10d,13d
	l3 equ $-m3

section .bss

	num1 resq 1
	num2 resq 1
	buff resq 1
	res resq 1

section .text
global _start
_start:
;=======================Accept Numbers=====================

	scall 1,1,m1,l1
	scall 0,0,buff,17
	call accept_proc

	mov [num1],bx

	scall 1,1,m2,l2
	scall 0,0,buff,17
	call accept_proc

	mov [num2],bx
	call addition

	mov rax,60
	mov rdi,0
	syscall
;========================Addition of Numbers==================

addition:

	scall 1,1,m3,l3
	mov rax,[num1]
	mov rbx,[num2]
	add rax,rbx
	
	call display_proc
	ret

;======================Display Procedure====================

display_proc:
		mov rbp,res
		mov rcx,16

up3:
		rol al,04h
		mov dl,al
	
		and dl,0fh
		
		cmp dl,09h
		jbe next1
		
		add dl,07h

next1:
		add dl,30h
		mov [rbp],dl

		inc rbp
		dec rcx
		jnz up3

		scall 1,1,res,17
ret


;============================Accept Procedure=================

accept_proc:
		mov rsi,buff
		mov rbx,0
		mov rax,0
		mov rcx,16
	
next_digit:
		rol rbx,04h
		mov al,[rsi]
		
		cmp al,39h
		jbe next
		sub al,07h

next:
		sub al,30h
		add bx,ax
		inc rsi
		dec rcx
		jnz next_digit
ret









