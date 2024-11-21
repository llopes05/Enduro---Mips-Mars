.text
	cores:
	addi $15, $0, 0x1818A5 #azul céu
	addi $16, $0, 0x074205 #verde grama
	addi $17, $0, 0xffffff #pista cor 1 (branco)
	addi $18, $0, 0x6B6B6B #pista cor 2 (cinza)
	addi $19, $0, 0x4A4A4A #pista cor 3 (cinza mais escuro)
	addi $20, $0, 0x848418 #cor nuvem
	addi $21, $0, 0x000000 #cor carro
	
	inputaddress:
	lui $25, 0xffff
	
	ceu:
	lui $7, 0x1001
	addi $8, $0, 5120
	
	forceu:
	beq $8, $0, l
	sw $15, 0($7)

	
	addi $7, $7, 4
	addi $8, $8, -1
	j forceu	
	l:
	
	coluna_cinza:         #o asfalto
	addi $8, $0, 11264

	for2: 
	beq $8, $0, lixo
	sw $16, 0($7)
	
	addi $7, $7, 4
	addi $8, $8, -1
	j for2
	lixo:

	
	la $4, 268520476
	li $5, 3
	li $6, 0x848418
	jal desenhalinha
	
	li $4, 268520984
	li $5, 5
	li $6, 0x848418
	jal desenhalinha
	
	la $4, 268520552
	li $5, 3
	li $6, 0x848418
	jal desenhalinha
	
	li $4, 268521060
	li $5, 5
	li $6, 0x848418
	jal desenhalinha
	
	la $4, 268520624
	li $5, 4
	li $6, 0x848418
	jal desenhalinha
	
	li $4, 268521132
	li $5, 6
	li $6, 0x848418
	jal desenhalinha
	
	la $4, 268520724
	li $5, 3
	li $6, 0x848418
	jal desenhalinha
	
	li $4, 268521232
	li $5, 5
	li $6, 0x848418
	jal desenhalinha
	
	la $4, 268520788
	li $5, 2
	li $6, 0x848418
	jal desenhalinha
	
	li $4, 268521296
	li $5, 4
	li $6, 0x848418
	jal desenhalinha
	
	la $4, 268520880
	li $5, 5
	li $6, 0x848418
	jal desenhalinha
	
	li $4, 268521388
	li $5, 7
	li $6, 0x848418
	jal desenhalinha
	
	
	j cabo
	desenhalinha:

	testlinha:
	beq $5, $0, fimlinha
	sw $6, 0($4)	 # função desenhalinha (recebe o endereço do começo da linha,
			 # o tamanho e a cor da linha, em $4, $5, $6, respectivamente)
	addi $5, $5, -1
	addi $4, $4, 4
	j testlinha
	fimlinha:
	jr $31

	linha_diagonal_1:
	beq $5, $0, fimlinhadiag1
	sw $6, 0($4)
	addi $4, $4, 512
	sw $6, 0($4)
	addi $4, $4, 516
	
	addi $5, $5, -1
	j linha_diagonal_1
	fimlinhadiag1:
	jr $31
	
	linha_diagonal_2:
	beq $5, $0, fimlinhadiag2
	sw $6, 0($4)
	addi $4, $4, 512
	sw $6, 0($4)
	addi $4, $4, 508
	
	addi $5, $5, -1
	j linha_diagonal_2
	fimlinhadiag2:
	li $2, 1
	syscall
	li $4, '\n'
	li $2, 11
	syscall
	jr $31
	
	cabo:
	li $4, 268521728
	li $5, 10
	li $6, 0x4A4A4A
	jal linha_diagonal_1
	
	li $4, 268532008
	li $5, 17
	li $6, 0x6B6B6B
	jal linha_diagonal_1
	
	li $4, 268549484
	li $5, 17
	li $6, 0xffffff
	jal linha_diagonal_1
	
	li $4, 268521728
	li $5, 10
	li $6, 0x4A4A4A
	jal linha_diagonal_2
	
	li $4, 268531928
	li $5, 17
	li $6, 0x6B6B6B
	jal linha_diagonal_2
	
	li $4, 268549268
	li $5, 17
	li $6, 0xffffff
	jal linha_diagonal_2
	
reset:	
	li $4, 268560608
	add $12, $4, $0 #endereço do carro do jogador em $12
	li $6, 0xffffff
	jal sprite7
	j npcmov
playermov:
	lw $23, 0($25)
	beq $23, $0, teste
	lw $23, 4($25)
	addi $10, $0, 'd'
	beq $23, $10, player_toright
	addi $10, $0 'a'
	beq $23, $10, player_toleft
	j teste
	
player_toright:
	add $4, $12, $0
	li $6, 0x074205
	jal sprite7
	
	add $12, $12, 8
	add $4, $12, $0
	li $6, 0xffffff
	jal sprite7
	
	j teste
	
player_toleft:
	add $4, $12, $0
	li $6, 0x074205
	jal sprite7
	
	add $12, $12, -8
	add $4, $12, $0
	li $6, 0xffffff
	jal sprite7
	
	j teste

npcmov:
	addi $22, $22, 1
	beq $22, 9, ganhou #numero de carros necessarios pra ganhar (9)
	li $5, 0xfffffe
	li $2, 42
	syscall
	add $17, $4, $0
	li $4, 268526328
	add $13, $4, $0  #endereço inicial do npc em $13
	add $6, $17, $0
	jal sprite1
	li $15, 1 # numero da sprite atual fica em $15
	
	li $5, 4
	li $2, 42
	syscall
	beq $4, 1, caminho1
	beq $4, 2, caminho2
	beq $4, 3, caminho3
caminho1:
	li $16, 1020
	j teste
caminho2:
	li $16, 1024
	j teste
caminho3:
	li $16, 1028
	
teste:
	li $14, 40
	beq $11, $14, fiim #numero de quantidade de movimentos fica em $11, $14 é apenas para fazer os testes
	li $14, 1
	beq $14, $15, fase1
	li $14, 2
	beq $14, $15, fase2
	li $14, 3
	beq $14, $15, fase3
	li $14, 4
	beq $14, $15, fase4
	li $14, 5
	beq $14, $15, fase5
	li $14, 6
	beq $14, $15, fase6
	li $14, 7
	beq $14, $15, fase7


fase1:
	li $15, 1
	li $14, 2
	bne $14, $11, keep1
	jal apagasprite
	j deleted1
keep1:	
	li $6, 0x074205 #cor do fundo (cor verde)
	add $4, $13, $0
	jal sprite1

	addi $13, $13, 1024 
	add $4, $13, $0 
	add $6, $17, $0
	jal sprite1
	
	addi $11, $11, 1
	
	li $4, 275
	li $2, 32
	syscall #syscall 32 ->sleep
deleted1:	
	j checkcollision
fase2:
	li $15, 2
	li $14, 4
	bne $14, $11, keep2
	jal apagasprite
	j deleted2
keep2:	
	li $6, 0x074205
	add $4, $13, $0
	jal sprite2
	
	addi $13, $13, 1024
	add $6, $17, $0
	add $4, $13, $0
	jal sprite2
	
	addi $11, $11, 1
	
	li $4, 300
	li $2, 32
	syscall
deleted2:
	j checkcollision
	
fase3:
	li $15, 3
	li $14, 7
	bne $14, $11, keep3
	jal apagasprite
	j deleted3
keep3:	
	
	li $6, 0x074205
	add $4, $13, $0
	jal sprite3

	addi $13, $13, 1028
	add $6, $17, $0
	add $4, $13, $0
	jal sprite3
	
	addi $11, $11, 1
	
	li $4, 300
	li $2, 32
	syscall
deleted3:	
	j checkcollision
	
fase4:
	li $15, 4
	li $14, 12
	bne $14, $11, keep4
	jal apagasprite
	j deleted4
keep4:	
	
	li $6, 0x074205
	add $4, $13, $0
	jal sprite4

	addi $13, $13, 1024
	add $6, $17, $0
	add $4, $13, $0
	jal sprite4
	
	addi $11, $11, 1
	
	li $4, 300
	li $2, 32
	syscall
deleted4:	
	j checkcollision
fase5:
	li $15, 5
	li $14, 17
	bne $14, $11, keep5
	jal apagasprite
	j deleted5
keep5:	
	
	li $6, 0x074205
	add $4, $13, $0
	jal sprite5

	add $13, $16, $13
	add $6, $17, $0
	add $4, $13, $0
	jal sprite5
	
	addi $11, $11, 1
	
	li $4, 300
	li $2, 32
	syscall
deleted5:
	j checkcollision
fase6:
	li $15, 6
	li $14, 22
	bne $14, $11, keep6
	jal apagasprite
	j deleted6
keep6:	
	
	li $6, 0x074205
	add $4, $13, $0
	jal sprite6

	add $13, $16, $13
	add $6, $17, $0
	add $4, $13, $0
	jal sprite6
	
	addi $11, $11, 1
	
	li $4, 300
	li $2, 32
	syscall
deleted6:	
	j checkcollision
fase7:
	li $15, 7
	
	li $6, 0x074205
	add $4, $13, $0
	jal sprite7
	add $13, $16, $13
	add $6, $17, $0
	add $4, $13, $0
	jal sprite7
	
	addi $11, $11, 1
	
	li $4, 300
	li $2, 32
	syscall
	
	j checkcollision
	
	
fiim:
	li $11, 0
	li $15, 1
	j npcmov
	
checkcollision:
	li $10, 0xff0000
	addi $4, $12, -4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, -4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 508
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	add $4, $12, -512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 516
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 4
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 516
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu
	addi $4, $4, 512
	lw $10, 0($4)
	beq $10, $17, perdeu

	j playermov
		
apagasprite:
	sw $31, 0($29)
	addi $29, $29, -4

	li $21, 1
	beq $21, $15, apaga1
	li $21, 2
	beq $21, $15, apaga2
	li $21, 3
	beq $21, $15, apaga3
	li $21, 4
	beq $21, $15, apaga4
	li $21, 5
	beq $21, $15, apaga5
	li $21, 6
	beq $21, $15, apaga6
apaga1:
	li $6,0x074205
	add $4, $13, $0
	jal sprite1
	li $15, 2
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
apaga2:
	li $6,0x074205
	add $4, $13, $0
	jal sprite2
	li $15, 3
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
apaga3:
	li $6,0x074205
	add $4, $13, $0
	jal sprite3
	li $15, 4
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
apaga4:
	li $6,0x074205
	add $4, $13, $0
	jal sprite4
	li $15, 5
	addi $29, $29, 4 
	lw $31, 0($29)
	jr $31
apaga5:
	li $6,0x074205
	add $4, $13, $0
	jal sprite5
	li $15, 6
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
apaga6:
	li $6,0x074205
	add $4, $13, $0
	jal sprite6
	li $15, 7
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
	
sprite1:
	sw $31, 0($29)
	addi $29, $29, -4

	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
sprite2:
	sw $31, 0($29)
	addi $29, $29, -4
	
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 504
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
sprite3:
	sw $31, 0($29)
	addi $29, $29, -4

	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 504
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 508
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
sprite4:
	sw $31, 0($29)
	addi $29, $29, -4

	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 500
	li $5, 5
	jal desenhalinha
	addi $4, $4, 496
	li $5, 5
	jal desenhalinha
	addi $4, $4, 488
	li $5, 5
	jal desenhalinha
	
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
sprite5:
	sw $31, 0($29)
	addi $29, $29, -4

	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 500
	li $5, 6
	jal desenhalinha
	addi $4, $4, 484
	sw $6, 0($4)
	addi $4, $4, 8
	li $5, 5
	jal desenhalinha
	addi $4, $4, 488
	li $5, 5
	jal desenhalinha
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 484
	sw $6, 0($4)
	addi $4, $4, 8
	li $5, 5
	jal desenhalinha
	addi $4, $4, 488
	li $5, 5
	jal desenhalinha
	addi $4, $4, 4
	sw $6, 0($4)
	
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
sprite6:
	sw $31, 0($29)
	addi $29, $29, -4

	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 484
	li $5, 12
	jal desenhalinha
	addi $4, $4, 464
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 12
	li $5, 4
	jal desenhalinha
	addi $4, $4, 488
	li $5, 10
	jal desenhalinha
	addi $4, $4, 464
	li $5, 10
	jal desenhalinha
	addi $4, $4, 480
	li $5, 10
	jal desenhalinha
	addi $4, $4, 464
	li $5, 10
	jal desenhalinha
	addi $4, $4, 488
	li $5, 4
	jal desenhalinha
	addi $4, $4, 8
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	
	addi $29, $29, 4
	lw $31, 0($29)
	jr $31
sprite7:
	sw $31, 0($29)
	addi $29, $29, -4

	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)	
	addi $4, $4, 16
	li $5, 5
	jal desenhalinha
	addi $4, $4, 12
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 456
	li $5, 15
	jal desenhalinha
	addi $4, $4, 452
	li $5, 15
	jal desenhalinha
	addi $4, $4, 452
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 16
	li $5, 5
	jal desenhalinha
	addi $4, $4, 20
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 440
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 12
	li $5, 13
	jal desenhalinha
	addi $4, $4, 452
	li $5, 13
	jal desenhalinha
	addi $4, $4, 8
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 440
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 12
	li $5, 13
	jal desenhalinha
	addi $4, $4, 452
	li $5, 13
	jal desenhalinha
	addi $4, $4, 8
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 440
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 12
	li $5, 13
	jal desenhalinha
	addi $4, $4, 452
	li $5, 13
	jal desenhalinha
	addi $4, $4, 8
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 440
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	addi $4, $4, 24
	li $5, 5
	jal desenhalinha
	addi $4, $4, 12
	sw $6, 0($4)
	addi $4, $4, 4
	sw $6, 0($4)
	
	addi $29, $29, 4
	lw $31, 0($29)
 	jr $31
perdeu:
	li $22, 0
	add $4, $13, $0
	li $6, 0x074205
	jal sprite7
	
	add $4, $12, $0
	li $6, 0x074205
	jal sprite7
	li $11, 0
	
	j reset
ganhou:
	vitoria:
	lui $7, 0x1001
	addi $8, $0, 16384
	
	forvitoria:
	beq $8, $0, lixao
	sw $21, 0($7)

	
	addi $7, $7, 4
	addi $8, $8, -1
	j forvitoria

	lixao:
	texto:
	lui $7, 0x1001
	textotrue:
	sw $17, 26780($7) #|
	sw $17, 26784($7) #|
	sw $17, 26788($7) #|
	sw $17, 26792($7) #|
	sw $17, 26812($7) #|   TEXTO
	sw $17, 26816($7) #|
	sw $17, 26820($7) #|
	sw $17, 26824($7) #|
	sw $17, 27292($7) #|
	sw $17, 27296($7) #|
	sw $17, 27300($7) #|
	sw $17, 27304($7) #|
	sw $17, 27324($7) #|
	sw $17, 27328($7) #|
	sw $17, 27332($7) #|
	sw $17, 27336($7) #|
	sw $17, 27804($7) #|
	sw $17, 27808($7) #|
	sw $17, 27812($7) #|
	sw $17, 27816($7) #|
	sw $17, 27836($7) #|
	sw $17, 27840($7) #|
	sw $17, 27844($7) #|
	sw $17, 27848($7) #|
	sw $17, 28316($7) #|
	sw $17, 28320($7) #|
	sw $17, 28324($7) #|
	sw $17, 28328($7) #|
	sw $17, 28348($7) #|
	sw $17, 28352($7) #|
	sw $17, 28356($7) #|
	sw $17, 28360($7) #|
	sw $17, 28828($7) #|
	sw $17, 28832($7) #|
	sw $17, 28836($7) #|
	sw $17, 28840($7) #|
	sw $17, 28860($7) #|
	sw $17, 28864($7) #|
	sw $17, 28868($7) #|
	sw $17, 28872($7) #|
	sw $17, 29340($7) #|
	sw $17, 29344($7) #|
	sw $17, 29348($7) #|
	sw $17, 29352($7) #|
	sw $17, 29372($7) #|
	sw $17, 29376($7) #|
	sw $17, 29380($7) #|
	sw $17, 29384($7) #|
	sw $17, 29852($7) #|
	sw $17, 29856($7) #|
	sw $17, 29860($7) #|
	sw $17, 29864($7) #|
	sw $17, 29884($7) #|
	sw $17, 29888($7) #|
	sw $17, 29892($7) #|
	sw $17, 29896($7) #|
	sw $17, 30364($7) #|
	sw $17, 30368($7) #|
	sw $17, 30372($7) #|
	sw $17, 30376($7) #|
	sw $17, 30396($7) #|
	sw $17, 30400($7) #|
	sw $17, 30404($7) #|
	sw $17, 30408($7) #|
	sw $17, 30876($7) #|
	sw $17, 30880($7) #|
	sw $17, 30884($7) #|
	sw $17, 30888($7) #|
	sw $17, 30908($7) #|
	sw $17, 30912($7) #|
	sw $17, 30916($7) #|
	sw $17, 30920($7) #|
	sw $17, 31388($7) #|
	sw $17, 31392($7) #|
	
	sw $17, 31396($7) #|
	sw $17, 31400($7) #|
	sw $17, 31420($7) #|
	sw $17, 31424($7) #|
	sw $17, 31428($7) #|
	sw $17, 31432($7) #|
	sw $17, 31900($7) #|
	sw $17, 31904($7) #|
	sw $17, 31908($7) #|
	sw $17, 31912($7) #|
	sw $17, 31932($7) #|
	sw $17, 31936($7) #|
	sw $17, 31940($7) #|
	sw $17, 31944($7) #|
	sw $17, 32416($7) #|
	sw $17, 32420($7) #|
	sw $17, 32424($7) #|
	sw $17, 32428($7) #|
	sw $17, 32432($7) #|
	sw $17, 32436($7) #|
	sw $17, 32440($7) #|
	sw $17, 32444($7) #|
	sw $17, 32448($7) #|
	sw $17, 32452($7) #|
	sw $17, 32940($7) #|
	sw $17, 32944($7) #|
	sw $17, 32948($7) #|
	sw $17, 32952($7) #|
	sw $17, 33452($7) #|
	sw $17, 33456($7) #|
	sw $17, 33460($7) #|
	sw $17, 33464($7) #|
	sw $17, 33964($7) #|
	sw $17, 33968($7) #|
	sw $17, 33972($7) #|
	sw $17, 33976($7) #|
	sw $17, 34476($7) #|
	sw $17, 34480($7) #|
	sw $17, 34484($7) #|
	sw $17, 34488($7) #|
	sw $17, 34988($7) #|
	sw $17, 34992($7) #|
	sw $17, 34996($7) #|
	sw $17, 35000($7) #|
	sw $17, 35500($7) #|
	sw $17, 35504($7) #|
	sw $17, 35508($7) #|
	sw $17, 35512($7) #|
	
	o1:
	lui $7, 0x1001
	addi $7, $7, 26836
	addi $15, $0, 12
	foro1:
	beq $15, $0, lo1
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro1
	lo1:
	
	o2:
	lui $7, 0x1001
	addi $7, $7, 27348
	addi $15, $0, 12
	foro2:
	beq $15, $0, lo2
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro2
	lo2:
	
	
	o3:
	lui $7, 0x1001
	addi $7, $7, 27860
	addi $15, $0, 12
	foro3:
	beq $15, $0, lo3
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro3
	lo3:
	
	
	o4:
	lui $7, 0x1001
	addi $7, $7, 28372
	addi $15, $0, 3
	foro4:
	beq $15, $0, lo4
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro4
	lo4:
	
	
	o5:
	lui $7, 0x1001
	addi $7, $7, 28884
	addi $15, $0, 3
	foro5:
	beq $15, $0, lo5
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro5
	lo5:
	
	o6:
	lui $7, 0x1001
	addi $7, $7, 29396
	addi $15, $0, 3
	foro6:
	beq $15, $0, lo6
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro6
	lo6:
	
	
	
	o7:
	lui $7, 0x1001
	addi $7, $7, 29908
	addi $15, $0, 3
	foro7:
	beq $15, $0, lo7
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro7
	lo7:
	
	o8:
	lui $7, 0x1001
	addi $7, $7, 30420
	addi $15, $0, 3
	foro8:
	beq $15, $0, lo8
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro8
	lo8:
	
	
	
	o9:
	lui $7, 0x1001
	addi $7, $7, 30932
	addi $15, $0, 3
	foro9:
	beq $15, $0, lo9
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro9
	lo9:
	
	
	o10:
	lui $7, 0x1001
	addi $7, $7, 31444
	addi $15, $0, 3
	foro10:
	beq $15, $0, lo10
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro10
	lo10:
	
	
	o11:
	lui $7, 0x1001
	addi $7, $7, 31956
	addi $15, $0, 3
	foro11:
	beq $15, $0, lo11
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro11
	lo11:
	
	o12:
	lui $7, 0x1001
	addi $7, $7, 32468
	addi $15, $0, 3
	foro12:
	beq $15, $0, lo12
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro12
	lo12:
	
	
	o13:
	lui $7, 0x1001
	addi $7, $7, 32980
	addi $15, $0, 3
	foro13:
	beq $15, $0, lo13
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro13
	lo13:
	
	o14:
	lui $7, 0x1001
	addi $7, $7, 33492
	addi $15, $0, 3
	foro14:
	beq $15, $0, lo14
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro14
	lo14:
	
	o15:
	lui $7, 0x1001
	addi $7, $7, 34004
	addi $15, $0, 3
	foro15:
	beq $15, $0, lo15
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro15
	lo15:
	
	
	
	
	
	
	
	
	
	
	
	o16:
	lui $7, 0x1001
	addi $7, $7, 28408
	addi $15, $0, 3
	foro16:
	beq $15, $0, lo16
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro16
	lo16:
	
	
	o17:
	lui $7, 0x1001
	addi $7, $7, 28920
	addi $15, $0, 3
	foro17:
	beq $15, $0, lo17
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro17
	lo17:
	
	o18:
	lui $7, 0x1001
	addi $7, $7, 29432
	addi $15, $0, 3
	foro18:
	beq $15, $0, lo18
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro18
	lo18:
	
	
	
	o19:
	lui $7, 0x1001
	addi $7, $7, 29944
	addi $15, $0, 3
	foro19:
	beq $15, $0, lo19
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro19
	lo19:
	
	o20:
	lui $7, 0x1001
	addi $7, $7, 30456
	addi $15, $0, 3
	foro20:
	beq $15, $0, lo20
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro20
	lo20:
	
	
	
	o21:
	lui $7, 0x1001
	addi $7, $7, 30968
	addi $15, $0, 3
	foro21:
	beq $15, $0, lo21
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro21
	lo21:
	
	
	o22:
	lui $7, 0x1001
	addi $7, $7, 31480
	addi $15, $0, 3
	foro22:
	beq $15, $0, lo22
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro22
	lo22:
	
	
	o23:
	lui $7, 0x1001
	addi $7, $7, 31992
	addi $15, $0, 3
	foro23:
	beq $15, $0, lo23
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro23
	lo23:
	
	o24:
	lui $7, 0x1001
	addi $7, $7, 32504
	addi $15, $0, 3
	foro24:
	beq $15, $0, lo24
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro24
	lo24:
	
	
	o25:
	lui $7, 0x1001
	addi $7, $7, 33016
	addi $15, $0, 3
	foro25:
	beq $15, $0, lo25
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro25
	lo25:
	
	o26:
	lui $7, 0x1001
	addi $7, $7, 33528
	addi $15, $0, 3
	foro26:
	beq $15, $0, lo26
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro26
	lo26:
	
	o27:
	lui $7, 0x1001
	addi $7, $7, 34040
	addi $15, $0, 3
	foro27:
	beq $15, $0, lo27
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro27
	lo27:
	
	o28:
	lui $7, 0x1001
	addi $7, $7, 34516
	addi $15, $0, 12
	foro28:
	beq $15, $0, lo28
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro28
	lo28:
	
	
	o29:
	lui $7, 0x1001
	addi $7, $7, 35028
	addi $15, $0, 12
	foro29:
	beq $15, $0, lo29
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro29
	lo29:
	
	
	o30:
	lui $7, 0x1001
	addi $7, $7, 35540
	addi $15, $0, 12
	foro30:
	beq $15, $0, lo30
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foro30
	lo30:
	
	u1:
    lui $7, 0x1001
    addi $7, $7, 26892
    addi $15, $0, 3
foru1:
    beq $15, $0, lu1
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru1
lu1:

u2:
    lui $7, 0x1001
    addi $7, $7, 27404
    addi $15, $0, 3
foru2:
    beq $15, $0, lu2
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru2
lu2:

u3:
    lui $7, 0x1001
    addi $7, $7, 27916
    addi $15, $0, 3
foru3:
    beq $15, $0, lu3
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru3
lu3:

u4:
    lui $7, 0x1001
    addi $7, $7, 28428
    addi $15, $0, 3
foru4:
    beq $15, $0, lu4
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru4
lu4:

u5:
    lui $7, 0x1001
    addi $7, $7, 28940
    addi $15, $0, 3
foru5:
    beq $15, $0, lu5
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru5
lu5:

u6:
    lui $7, 0x1001
    addi $7, $7, 29452
    addi $15, $0, 3
foru6:
    beq $15, $0, lu6
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru6
lu6:

u7:
    lui $7, 0x1001
    addi $7, $7, 29964
    addi $15, $0, 3
foru7:
    beq $15, $0, lu7
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru7
lu7:

u8:
    lui $7, 0x1001
    addi $7, $7, 30476
    addi $15, $0, 3
foru8:
    beq $15, $0, lu8
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru8
lu8:

u9:
    lui $7, 0x1001
    addi $7, $7, 30988
    addi $15, $0, 3
foru9:
    beq $15, $0, lu9
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru9
lu9:

u10:
    lui $7, 0x1001
    addi $7, $7, 31500
    addi $15, $0, 3
foru10:
    beq $15, $0, lu10
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru10
lu10:

u11:
    lui $7, 0x1001
    addi $7, $7, 32012
    addi $15, $0, 3
foru11:
    beq $15, $0, lu11
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru11
lu11:

u12:
    lui $7, 0x1001
    addi $7, $7, 32524
    addi $15, $0, 3
foru12:
    beq $15, $0, lu12
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru12
lu12:

u13:
    lui $7, 0x1001
    addi $7, $7, 33036
    addi $15, $0, 3
foru13:
    beq $15, $0, lu13
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru13
lu13:

u14:
    lui $7, 0x1001
    addi $7, $7, 33548
    addi $15, $0, 3
foru14:
    beq $15, $0, lu14
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru14
lu14:

u15:
    lui $7, 0x1001
    addi $7, $7, 34060
    addi $15, $0, 3
foru15:
    beq $15, $0, lu15
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru15
lu15:

u16:
    lui $7, 0x1001
    addi $7, $7, 34572
    addi $15, $0, 3
foru16:
    beq $15, $0, lu16
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru16
lu16:

u17:
    lui $7, 0x1001
    addi $7, $7, 30456
    addi $15, $0, 3
foru17:
    beq $15, $0, lu17
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru17
lu17:

u18:
    lui $7, 0x1001
    addi $7, $7, 26928
    addi $15, $0, 3
foru18:
    beq $15, $0, lu18
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru18
lu18:

u19:
    lui $7, 0x1001
    addi $7, $7, 27440
    addi $15, $0, 3
foru19:
    beq $15, $0, lu19
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru19
lu19:

u20:
    lui $7, 0x1001
    addi $7, $7, 27952
    addi $15, $0, 3
foru20:
    beq $15, $0, lu20
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru20
lu20:

u21:
    lui $7, 0x1001
    addi $7, $7, 28464
    addi $15, $0, 3
foru21:
    beq $15, $0, lu21
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru21
lu21:

u22:
    lui $7, 0x1001
    addi $7, $7, 28976
    addi $15, $0, 3
foru22:
    beq $15, $0, lu22
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru22
lu22:

u23:
    lui $7, 0x1001
    addi $7, $7, 29488
    addi $15, $0, 3
foru23:
    beq $15, $0, lu23
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru23
lu23:

u24:
    lui $7, 0x1001
    addi $7, $7, 30000
    addi $15, $0, 3
foru24:
    beq $15, $0, lu24
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru24
lu24:

u25:
    lui $7, 0x1001
    addi $7, $7, 30512
    addi $15, $0, 3
foru25:
    beq $15, $0, lu25
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru25
lu25:

u26:
    lui $7, 0x1001
    addi $7, $7, 31024
    addi $15, $0, 3
foru26:
    beq $15, $0, lu26
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru26
lu26:

u27:
    lui $7, 0x1001
    addi $7, $7, 31536
    addi $15, $0, 3
foru27:
    beq $15, $0, lu27
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru27
lu27:

u28:
    lui $7, 0x1001
    addi $7, $7, 32048
    addi $15, $0, 3
foru28:
    beq $15, $0, lu28
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru28
lu28:

u29:
    lui $7, 0x1001
    addi $7, $7, 32560
    addi $15, $0, 3
foru29:
    beq $15, $0, lu29
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru29
lu29:

u30:
    lui $7, 0x1001
    addi $7, $7, 33072
    addi $15, $0, 3
foru30:
    beq $15, $0, lu30
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru30
lu30:

u31:
    lui $7, 0x1001
    addi $7, $7, 33584
    addi $15, $0, 3
foru31:
    beq $15, $0, lu31
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru31
lu31:

u32:
    lui $7, 0x1001
    addi $7, $7, 34096
    addi $15, $0, 3
foru32:
    beq $15, $0, lu32
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru32
lu32:

u33:
    lui $7, 0x1001
    addi $7, $7, 34608
    addi $15, $0, 3
foru33:
    beq $15, $0, lu33
    sw $17, 0($7)
    addi $7, $7, 4
    addi $15, $15, -1
    j foru33
lu33:

	u34:
	lui $7, 0x1001
	addi $7, $7, 35084
	addi $15, $0, 12
	foru34:
	beq $15, $0, lu34
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foru34
	lu34:
	
	u35:
	lui $7, 0x1001
	addi $7, $7, 35596
	addi $15, $0, 12
	foru35:
	beq $15, $0, lu35
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j foru35
	lu35:
	
	
	w1:
	lui $7, 0x1001
	addi $7, $7, 38040
	addi $15, $0, 15
	forw1:
	beq $15, $0, lw1
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw1
	lw1:
	
	w2:
	lui $7, 0x1001
	addi $7, $7, 38044
	addi $15, $0, 15
	forw2:
	beq $15, $0, lw2
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw2
	lw2:
	
	w4:
	lui $7, 0x1001
	addi $7, $7, 38048
	addi $15, $0, 15
	forw3:
	beq $15, $0, lw4
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw3
	lw4:
	
	w5:
	lui $7, 0x1001
	addi $7, $7, 38052
	addi $15, $0, 15
	forw5:
	beq $15, $0, lw5
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw5
	lw5:
	
	w6:
	lui $7, 0x1001
	addi $7, $7, 38088
	addi $15, $0, 15
	forw6:
	beq $15, $0, lw6
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw6
	lw6:
	
	w7:
	lui $7, 0x1001
	addi $7, $7, 38092
	addi $15, $0, 15
	forw7:
	beq $15, $0, lw7
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw7
	lw7:
	
	w8:
	lui $7, 0x1001
	addi $7, $7, 38096
	addi $15, $0, 15
	forw8:
	beq $15, $0, lw8
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw8
	lw8:
	
	w9:
	lui $7, 0x1001
	addi $7, $7, 38100
	addi $15, $0, 15
	forw9:
	beq $15, $0, lw9
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw9
	lw9:
	
	
	w10:
	lui $7, 0x1001
	addi $7, $7, 38576
	addi $15, $0, 14
	forw10:
	beq $15, $0, lw10
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw10
	lw10:
	
	w11:
	lui $7, 0x1001
	addi $7, $7, 38580
	addi $15, $0, 14
	forw11:
	beq $15, $0, lw11
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw11
	lw11:
	
	w12:
	lui $7, 0x1001
	addi $7, $7, 38584
	addi $15, $0, 14
	forw12:
	beq $15, $0, lw12
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw12
	lw12:
	
	w13:
	lui $7, 0x1001
	addi $7, $7, 38588
	addi $15, $0, 14
	forw13:
	beq $15, $0, lw13
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forw13
	lw13:
	
	w14:
	lui $7, 0x1001
	addi $7, $7, 45728
	addi $15, $0, 12
	forw14:
	beq $15, $0, lw14
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j forw14
	lw14:
	
	w15:
	lui $7, 0x1001
	addi $7, $7, 46240
	addi $15, $0, 12
	forw15:
	beq $15, $0, lw15
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j forw15
	lw15:
	
	
	i1:
	lui $7, 0x1001
	addi $7, $7, 39660
	addi $15, $0, 14
	fori1:
	beq $15, $0, li1
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j fori1
	li1:
	
	i2:
	lui $7, 0x1001
	addi $7, $7, 39664
	addi $15, $0, 14
	fori2:
	beq $15, $0, li2
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j fori2
	li2:
	
	i3:
	lui $7, 0x1001
	addi $7, $7, 39668
	addi $15, $0, 14
	fori3:
	beq $15, $0, li3
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j fori3
	li3:
	
	i4:
	lui $7, 0x1001
	addi $7, $7, 38124
	addi $15, $0, 3
	fori4:
	beq $15, $0, li4
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j fori4
	li4:
	
	i5:
	lui $7, 0x1001
	addi $7, $7, 38636
	addi $15, $0, 3
	fori5:
	beq $15, $0, li5
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j fori5
	li5:
	
	n1:
	lui $7, 0x1001
	addi $7, $7, 38148
	addi $15, $0, 17
	forn1:
	beq $15, $0, ln1
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn1
	ln1:
	
	n2:
	lui $7, 0x1001
	addi $7, $7, 38152
	addi $15, $0, 17
	forn2:
	beq $15, $0, ln2
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn2
	ln2:
	
	n3:
	lui $7, 0x1001
	addi $7, $7, 38156
	addi $15, $0, 17
	forn3:
	beq $15, $0, ln3
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn3
	ln3:
	
	n4:
	lui $7, 0x1001
	addi $7, $7, 38192
	addi $15, $0, 17
	forn4:
	beq $15, $0, ln4
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn4
	ln4:
	
	n5:
	lui $7, 0x1001
	addi $7, $7, 38196
	addi $15, $0, 17
	forn5:
	beq $15, $0, ln5
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn5
	ln5:
	
	n6:
	lui $7, 0x1001
	addi $7, $7, 38160
	addi $15, $0, 2
	forn6:
	beq $15, $0, ln6
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn6
	ln6:
	
	n7:
	lui $7, 0x1001
	addi $7, $7, 38164
	addi $15, $0, 4
	forn7:
	beq $15, $0, ln7
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn7
	ln7:
	
	n8:
	lui $7, 0x1001
	addi $7, $7, 38680
	addi $15, $0, 5
	forn8:
	beq $15, $0, ln8
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn8
	ln8:
	
	n9:
	lui $7, 0x1001
	addi $7, $7, 39708
	addi $15, $0, 6
	forn9:
	beq $15, $0, ln9
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn9
	ln9:
	
	n10:
	lui $7, 0x1001
	addi $7, $7, 41248
	addi $15, $0, 6
	forn10:
	beq $15, $0, ln10
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn10
	ln10:
	
	n11:
	lui $7, 0x1001
	addi $7, $7, 42276
	addi $15, $0, 6
	forn11:
	beq $15, $0, ln11
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn11
	ln11:
	
	n12:
	lui $7, 0x1001
	addi $7, $7, 43816
	addi $15, $0, 6
	forn12:
	beq $15, $0, ln12
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn12
	ln12:
	
	n13:
	lui $7, 0x1001
	addi $7, $7, 45356
	addi $15, $0, 3
	forn13:
	beq $15, $0, ln13
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j forn13
	ln13:
	
	e1:
	lui $7, 0x1001
	addi $7, $7, 38212
	addi $15, $0, 14
	fore1:
	beq $15, $0, le1
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j fore1
	le1:
	
	e2:
	lui $7, 0x1001
	addi $7, $7, 38216
	addi $15, $0, 14
	fore2:
	beq $15, $0, le2
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j fore2
	le2:
	
	e3:
	lui $7, 0x1001
	addi $7, $7, 38220
	addi $15, $0, 14
	fore3:
	beq $15, $0, le3
	sw $17, 0($7)
	addi $7, $7, 512
	addi $15, $15, -1
	j fore3
	le3:
	
	e4:
	lui $7, 0x1001
	addi $7, $7, 45892
	addi $15, $0, 3
	fore4:
	beq $15, $0, le4
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j fore4
	le4:
	
	e5:
	lui $7, 0x1001
	addi $7, $7, 46404
	addi $15, $0, 3
	fore5:
	beq $15, $0, le5
	sw $17, 0($7)
	addi $7, $7, 4
	addi $15, $15, -1
	j fore5
	le5:

