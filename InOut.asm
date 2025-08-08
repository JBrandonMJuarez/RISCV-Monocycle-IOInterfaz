.text
	# Configuración de InterfazIO
	addi	t1,zero, 0x01	#Cargo palabra de configuracion 01 (Data_A como entrada; Data_B,Data_C como salidas
	sw	t1,128(zero)	#Almaceno palabra de configuración en TRC (Nuevo: ICR - Interface Control Register)
	Inicio:
	lw	t0,132(zero)
	sw	t0,136(zero)
	beq	zero,zero,Inicio