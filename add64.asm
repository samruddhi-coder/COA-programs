%macro scall 4

	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall

%endmacro

section .data

	m1 db "Enter size of an array:",10d,13d
	l1 equ $-m1
	
	m2 db "Enter Number:",10d,13d
	l2 equ $-m2
	
	m3 db "Array Contents are:",10d,13d
	l3 equ $-m3
	
	m4 db "The addition is:",10d,13d
	l4 equ $-m4
	
	m5 db " ",10d,13d
	l5 equ $-m5

section .bss

	num resq 20
	cnt resq 20
	cnt1 resq 20
	cnt2 resq 20
	array resq 200
	char_ans resq 20

section .text
global _start
_start:

;==========================Array Size===========================================

	scall 1,1,m1,l1
	scall 0,0,num,17
	
	call accept_proc
	
	mov [cnt],bx
	mov [cnt1],bx
	mov [cnt2],bx
			
;==========================Accept Array Elements================================

	mov rbp,array

up1:
	scall 1,1,m2,l2
	scall 0,0,num,17

	call accept_proc
	
	mov [rbp],bx
	add rbp,2
	dec byte[cnt]
	jnz up1

;=========================Display Array Elements================================

	scall 1,1,m3,l3
	mov rbx,array

up2:
	mov ax,[rbx]

	call display_proc

	add rbx,2
	dec byte[cnt1]
	jnz up2

;========================Addition Of Elements===================================

	scall 1,1,m4,l4

back1:
	mov ax,00h
	mov bx,00h
	
	mov rbx,array

back2:
	add ax,[rbx]
	add rbx,2
	
	dec byte[cnt2]
	jnz back2

	call display_proc

;==============================Exit=============================================

	mov rax,60
	mov rdi,0
	syscall

;============================Accept Procedure===================================

accept_proc:
		mov rsi,num
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

;===========================Display Procedure==================================

display_proc:
		mov rbp,char_ans
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

		scall 1,1,char_ans,17
		scall 1,1,m5,l5
ret

