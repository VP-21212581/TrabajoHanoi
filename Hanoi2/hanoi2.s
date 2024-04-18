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
prompt:	.asciz	"How many disk do you want to move? "
format:	.asciz	"%d"	
string: .asciz  "move disk from %c to %c\n\0"
peg1:	.int	'A'		@ Clavije a usar, requiere ser un char
peg2:	.int	'B'
peg3:	.int	'C'
n:	.int	4		@ Cantidad de discos a mover

	
@ ---------------------------------------
@	Código
@ ---------------------------------------
	
	.text
	.global main
	.extern printf
	.extern	scanf

@ ---------------------------------------
@ getNumberOfDisks():
@ Pide la cantidad de discos a usar, y lo almacena en n
getNumberOfDisks:
	push 	{ip, lr}	@ Se hace push al return address y dummy register

	ldr	r0, =prompt	@ Despliega la petición
	bl	printf

	ldr     r0, =format	@ Escanea el valor insertado
	ldr	r1, =n		@ Se almacena en r0 y r1
	bl	scanf		@ r0 es el string y r1 la dirección

        pop 	{ip, pc}
	
@ ---------------------------------------
@ Equivalente de mover discos usando la cantidad, el origen, el destino, y un valor adicional
@ r4, r5, r6 y r7 respectivamente
@	
moveDisks:	
	push	{r4-r8, lr}

	@ Compara si vale 1
	cmp	r4, #1
	bgt	moveN_1Disks

move1Disk:	
	@ Movimiento de origen a destino
	ldr	r0, =string
	mov	r1, r5
	mov	r2, r6
	bl	printf
	b	endMoveDisk

moveN_1Disks:	
	@ Mueve discos otra vez
	mov	r8, r7		@ Cambia los valores del destino y el valor adicional
	mov	r7, r6
	mov	r6, r8
	sub	r4, #1
	bl	moveDisks
	mov	r8, r7		@ Devuelve los valores a sus posiciones originales
	mov	r7, r6
	mov	r6, r8

	@ Imprime en pantalla el movimiento de origen a disco
	ldr	r0, =string
	mov	r1, r5
	mov	r2, r6
	bl	printf

	@ Mueve discos una tercera vez
	mov	r8, r5		@ Cambia valores de origen y el adicional
	mov	r5, r7
	mov	r7, r8
	bl	moveDisks
	
endMoveDisk:	
	pop	{r4-r8, pc}

	
@ ---------------------------------------
@ main: call moveDisks( n, peg1, peg2, peg3 )

main:   push 	{ip, lr}	@ push return address + dummy register
				@ for alignment

	bl	getNumberOfDisks
				@ get n
	
	ldr	r4, =n		@ pass n
	ldr	r4, [r4]
	ldr	r5, =peg1	@ pass peg1
	ldr	r5, [r5]
	ldr	r6, =peg2	@ pass peg2
	ldr	r6, [r6]
	ldr	r7, =peg3	@ pass peg3
	ldr	r7, [r7]
	bl	moveDisks	@ call moveDisks( n, peg1, peg2, peg3 )

	
@ return to OS	
        pop 	{ip, pc}	@ pop return address into pc

