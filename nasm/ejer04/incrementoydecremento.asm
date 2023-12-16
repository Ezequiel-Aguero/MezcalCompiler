section .data
        userMsg1 db "ingrese un numero: ", 0xA, 0xD
        len1 equ $ - userMsg1
        dispRes1 db "Incremento: ", 0xA, 0xD
        len2 equ $ - dispRes1
        dispRes2 db "Decremento: ", 0xA, 0xD
        len3 equ $ - dispRes2

section .bss
        num1 resb 5
        resINC resb 5
        resDEC resb 5

section .text
        global _start

_start:
        ; Impresion del userMsg1
        mov eax, 4
        mov ebx, 1
        mov ecx, userMsg1
        mov edx, len1
        int 0x80


        ;Lectura desde el teclado
        mov eax, 3
        mov ebx, 1
        mov ecx, num1
        mov edx, 5
        int 0x80

	;operacion para el incremento
	mov eax, [num1]
	inc eax
	mov [resINC], eax

        ;Imprimiendo el comentario del incremento
        mov eax, 4
        mov ebx, 1
        mov ecx, dispRes1
        mov edx, len2
        int 0x80

        ;Imprimiendo el incremento
	mov eax, 4
	mov ebx, 1
	mov ecx, resINC
	mov edx, 5
	int 0x80

        ;Operacion del decremento
	mov eax, [num1]
	dec eax
	mov [resDEC], eax

        ;Imprimiendo comentario del decremento
	mov eax, 4
	mov ebx, 1
	mov ecx, dispRes2
	mov edx, len3
	int 0x80


        ;Imprimiendo el decremento
	mov eax, 4
	mov ebx, 1
	mov ecx, resDEC
	mov edx, 5
	int 0x80

        ;Closing program

mov eax, 1
int 0x80

