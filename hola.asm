.text
	# Configuraci�n de InterfazIO
	addi	t1,zero, 0x01	#Cargo palabra de configuracion 01 (Data_A como entrada; Data_B,Data_C como salidas
	sw	t1,128(zero)	#Almaceno palabra de configuraci�n en TRC
	
	addi	a0,zero,3
	addi	a1,zero,2
	addi	a2,zero,1
	
	Principal:
	addi	t0,zero,4		# Defino puntero de salto
	addi	t5,zero,1		# Bit de habilitaci�n de display
	xori	t5,t5,0x1ff
	addi	t1,zero,0x76		# Cargo valor para letra H
	sw	t1,136(zero)		# Muevo valor H al registro de salida
	sw	t5,140(zero)		# Habilito primer display
	beq	zero,zero,espera	# Salto a ciclo de espera
	
	letrao:
	slli	t5,t5,1			# Desplazo bit de activaci�n
	addi	t5,t5,1			
	addi	t1,zero,0x3F		# Cargo valor para letra O
	sw	t1,136(zero)		# Muevo valor O al registro de salida
	sw	t5,140(zero)		# Habilito segundo display
	beq	zero,zero,espera	# Salto a ciclo de espera
	
	letral:
	slli	t5,t5,1			# Desplazo bit de activaci�n
	addi	t5,t5,1			
	addi	t1,zero,0x38		# Cargo valor para letra L
	sw	t1,136(zero)		# Muevo valor L al registro de salida
	sw	t5,140(zero)		# Habilito tercer display
	beq	zero,zero,espera	# Salto a ciclo de espera
	
	letraa:
	slli	t5,t5,1			# Desplazo bit de activaci�n
	addi	t5,t5,1			
	addi	t1,zero,0x77		# Cargo valor para letra A
	sw	t1,136(zero)		# Muevo valor A al registro de salida
	sw	t5,140(zero)		# Habilito tercer display
	beq	zero,zero,espera	# Salto a ciclo de espera
	final:
	beq	zero,zero,Principal	# Regresa a repetir letra H
	

	espera:
	addi	t3,zero,0x01		# Carga de contador de letras en t3
	sub	t0,t0,t3		# Copia el contador en t0
	addi	t2,zero,0X007		# Carga de contador de retardo
	slli	t2,t2,4			
	addi	t2,t2,0x01		# Incremento del contador
	slli	t2,t2,10		# Desplazamiento del contador
	addi	t2,t2,0x01		# Incremento del contador
	tiempo:
	sub	t2,t2,t3		# Decrementa para retardar
	bne	t2,zero,tiempo		# Si el contador llega a cero salta
	beq	t0,a0,letrao		# Si recorri� letra H, salta a letra O
	beq	t0,a1,letral		# Si recorri� letra O, salta a letra L
	beq	t0,a2,letraa		# Si recorri� letra L, salta a letra A
	beq	t0,zero,final		# Si recorri� letra A, salta a letra H
	
	
	
	
	
	
	
	
