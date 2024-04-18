@   Van Pratt González Ricardo Adolfo
@   21212581
@   Instituto Tecnológico de Tijuana, Ingeniería en Sistemas Computacionales
@   Lenguajes de Interfaz 15:00 a 16:00 horas
@   Sexto Semestre
@ ---------------------------------------
@	Datos
@ ---------------------------------------
	
	.data
	.balign 4	
string: .asciz  "move disk from %c to %c\n\0"
peg1:	.int	'A'		@ Clavija uno, deben ser chars
peg2:	.int	'B'
peg3:	.int	'C'
n:	.int	4		@ Cantidad de discos a usar

	
@ ---------------------------------------
@	Código
@ ---------------------------------------
	
	.text
	.global main
	.extern printf

	
@ ---------------------------------------
@ 	Equivalente para mover discos
@	r4 = Valor de discos
@	r5 = Clavija de donde se mueve
@	r6 = Clavija a la que se mueve
@	r7 = Valor adicional para intercambio de valores
	
moveDisks:	
	push	{r4-r8, lr}

	@ if n==1:
	cmp	r4, #1
	bgt	moveN_1Disks

move1Disk:	
	@ Imprime en pantalla del origen al destino
	ldr	r0, =string
	mov	r1, r5
	mov	r2, r6
	bl	printf
	b	endMoveDisk

moveN_1Disks:	
	@ Mueve la cantidad de discos menos uno, origen, destino, y adicional
	mov	r8, r7		@ Se intercambian los valores de destino y el adicional
	mov	r7, r6
	mov	r6, r8
	sub	r4, #1
	bl	moveDisks
	mov	r8, r7		@ Se intercambian de vuelta los valores
	mov	r7, r6
	mov	r6, r8

	@ Imprime en pantalla del origen al destino
	ldr	r0, =string
	mov	r1, r5
	mov	r2, r6
	bl	printf

	@ Otro movimiento de discos, usando n-1	
	mov	r8, r5		@ Cambio entre origen y adicional, tipo r5 y r7.
	mov	r5, r7
	mov	r7, r8
	bl	moveDisks
	
endMoveDisk:	
	pop	{r4-r8, pc}

	
@ ---------------------------------------
@ main: Es la llamada de moveDisks( n, peg1, peg2, peg3 )

main:   push 	{ip, lr}	@ push de "return address" y "dummy register"

	ldr	r4, =n		@ Pasa n
	ldr	r4, [r4]
	ldr	r5, =peg1	@ Pasa peg1
	ldr	r5, [r5]
	ldr	r6, =peg2	@ Pasa peg2
	ldr	r6, [r6]
	ldr	r7, =peg3	@ Pasa peg3
	ldr	r7, [r7]
	bl	moveDisks	@ Se llama a moveDisks( n, peg1, peg2, peg3 )

	
@ Se regresa al SO	
        pop 	{ip, pc}	@ pop return address into pc
