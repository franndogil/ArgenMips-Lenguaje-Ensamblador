.data
CONTROL:	.word	0x10000
DATA:		.word	0x10008
amarillo:	.byte	255, 255, 0, 0
celeste:	.byte	0, 255, 255, 0

.code
daddi $sp, $0, 0x400			#inicializo la pila 
ld $s0, CONTROL ($0)
ld $s1, DATA ($0)
jal pintar_abajo
jal pintar_arriba
jal pintar_sol
halt

pintar_abajo:  	lwu $s2, celeste($0)
 	      	sw $s2, 0($s1)		#cargo el color en data
	      	daddi $t0, $0, 49
	      	daddi $t1, $0, 15
	      	daddi $t3, $0, -1
lazo1:	      	daddi $t2, $0, -1
	      	beq $t3, $t1, fin1
	      	daddi $t3, $t3, 1
lazo2:	      	beq $t2, $t0, lazo1
	      	daddi $t2, $t2, 1
					#cargo en data las coordenadas
 	      	sb $t2, 5($s1)
 	      	sb $t3, 4($s1)

		daddi $t5, $0, 5	#envio la muestra en terminal a control
		sd $t5, 0($s0)
		j lazo2
	      
fin1:	      	jr $ra			#vuelvo al programa principal

pintar_arriba:  lwu $s2, celeste($0)
 	      	sw $s2, 0($s1)		#cargo el color en data
	      	daddi $t0, $0, 49
	      	daddi $t1, $0, 49
	      	daddi $t3, $0, 33
lazo3:	      	daddi $t2, $0, -1
	      	beq $t3, $t1, fin2
	      	daddi $t3, $t3, 1
lazo4:	      	beq $t2, $t0, lazo3
	      	daddi $t2, $t2, 1
					#cargo en data las coordenadas
 	      	sb $t2, 5($s1)
 	      	sb $t3, 4($s1)

		daddi $t5, $0, 5	#envio la muestra en terminal a control
		sd $t5, 0($s0)
		j lazo4
	      
fin2:	      	jr $ra			#vuelvo al programa principal

pintar_sol:	daddi $sp, $sp, -8	#PUSH
		sd $ra, 0 ($sp)

		daddi $s3, $0, 5
		daddi $a0, $0, 19	#coordenadas iniciales
		daddi $a1, $0, 25
		lwu $s2, amarillo($0)
 	      	sw $s2, 0($s1)		#cargo el color en data

lazo5:		beqz $s3, segunda_parte
		daddi $s3, $s3, -1
		daddi $a0, $a0, 1	#avanzo 1 pixel en X
		daddi $a1, $a1, -1	#disminuyo 1 pixel en Y
		daddi $a2, $a2, 2	#envio por parametros la cantidad de pixeles a pintar
		
		jal pintar_linea
		j lazo5

segunda_parte:	daddi $s3, $0, 4

lazo6:		beqz $s3, fin3
		daddi $s3, $s3, -1
		daddi $a0, $a0, 1	#avanzo 1 pixel en X
		daddi $a1, $a1, 1	#aumento 1 pixel en Y
		daddi $a2, $a2, -2	#envio por parametros la cantidad de pixeles a pintar
		jal pintar_linea
		j lazo6

fin3:		ld $ra, 0 ($sp)
		daddi $sp, $sp, 8	#POP 
		jr $ra

pintar_linea:	dadd $t2, $0, $a2
		dadd $t3, $0, $a1
		sb $a0, 5($s1)
lazo7:		beqz $t2, fin4
 	      	sb $t3, 4($s1)
		daddi $t5, $0, 5	#envio la muestra en terminal a control
		sd $t5, 0($s0)
		daddi $t3, $t3, 1
		daddi $t2, $t2, -1
		j lazo7

fin4:		jr $ra


#Franco Matias Dogil	02/12/2024

