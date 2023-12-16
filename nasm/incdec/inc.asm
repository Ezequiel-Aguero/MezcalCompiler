section .bss
	res resb 1

section .text
	global _start

_start:
	mov eax, 1
	inc eax
	add eax, '0'
	mov [res], eax

	; printing
	mov eax, 4
	mov ebx, 1
	mov ecx, res
	mov edx, 1
	int 0x80

mov eax, 1
int 0x80


