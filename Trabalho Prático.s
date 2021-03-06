# Trabalho Prático de Arquitetura de computadores
# Produzido por Pedro Belo e Davi Santos


.data 
 

mensagem: .asciiz "Treinamento nº "
mensagemread: .asciiz "Informe um numero para somar: "
mensagem_w0: .asciiz " Peso w0 ajustado: "
mensagem_w1: .asciiz " Peso w1 ajustado: "
mensagemResult: .asciiz " Resultado: "
mensagemexecucao: .asciiz "Execucao... "
resultadoEsperado: .asciiz " Resultado Esperado: "
diferenca: .asciiz " Diferença: "
 
espaco: .asciiz "\n"
w0: .float 0.00
w1: .float 0.80    
incremento: .float 1.00
aprendizado: .float 0.05
 
theArray:
.align 2
.space 40
 
.text 
 
main: 
    addi $s1, $s1, 4
    add $t1, $zero, $zero
 

#TREINAMENTO 
    #carregando os valores dos pesos
    lwc1 $f2, w0
    lwc1 $f3, w1
 
    
 
While: slti $t1, $t0, 5
    beq $t1, $zero, FIM
    mul $t1, $t0, $s1

    #Adicionar 1 e guarda na memoria
    lwc1 $f13, incremento
    add.s $f15, $f15, $f13
    swc1 $f15, theArray($t1)

    lwc1 $f1, theArray($t1) #Pega os valores do vetor que foi armazenado na memoria

    #Imprimindo o numero do treinamento 
    li $v0, 4
    la $a0, mensagem
    syscall

    #Imprimindo os numeros 
    li $v0, 1  
    move $a0, $t0
    syscall

    #Imprimindo a palavra resultado
    li $v0, 4
    la $a0, mensagemResult
    syscall

    mul.s $f4, $f2, $f1
    mul.s $f5, $f3, $f1

    add.s $f6, $f4, $f5 #resultado

    #Imprimindo resultado
    li $v0, 2
    mov.s $f12, $f6
    syscall

    add.s $f7, $f1, $f1 #Resultado esperado
    sub.s $f8, $f7, $f6 #Diferença

    #Imprimindo string - resultado esperado
    li $v0, 4
    la $a0, resultadoEsperado
    syscall

    #Imprimindo resultado esperado
    li $v0, 2
    mov.s $f12, $f7
    syscall

    #Imprimindo string - diferenca
    li $v0, 4
    la $a0, diferenca
    syscall

    #Imprimindo valor diferença
    li $v0, 2
    mov.s $f12, $f8
    syscall

    #Imprimindo o \n
    li $v0, 4
    la $a0, espaco
    syscall

    #Ajustando os pesos 
    lwc1 $f9, aprendizado #carregando a taxa de aprendizado
 
    #Ajuste do peso w0
    mul.s $f10, $f8, $f9
    mul.s $f10, $f10, $f1
    add.s $f2, $f2, $f10

    #Ajuste do peso w1
    mul.s $f10, $f8, $f9
    mul.s $f10, $f10, $f1
    add.s $f3, $f3, $f10

    #Imprimindo string - w0
        li $v0, 4
    la $a0, mensagem_w0
    syscall

    #Imprimindo novo valor w0
    li $v0, 2
    mov.s $f12, $f2
    syscall

    #Imprimindo o \n
    li $v0, 4
    la $a0, espaco
    syscall

    #Imprimindo string - w1
    li $v0, 4
    la $a0, mensagem_w1
    syscall

    #Imprimindo novo valor w1
    li $v0, 2
    mov.s $f12, $f3
    syscall

    #Imprimindo o \n
    li $v0, 4
    la $a0, espaco
    syscall

    addi $t0, $t0, 1
    blt $t1, 40, While #Fim do While de treinamento

 
#Execução
FIM:
 
 
    #Imprimindo o \n
    li $v0, 4
    la $a0, espaco
    syscall
 
    #Solitação de comando para o usuário
        li $v0, 4
    la $a0, mensagemread
    syscall
  
    li $v0, 6
    syscall
 
    mul.s $f4, $f2, $f0
    mul.s $f5, $f3, $f0

    add.s $f6, $f4, $f5
 
    #\n
    li $v0, 4
    la $a0, espaco
    syscall
	
	 #Mensagem - resultado
        li $v0, 4
    la $a0, mensagemResult
    syscall

    #Imprimindo resultado esperado
    li $v0, 2
    mov.s $f12, $f6
    syscall


jr $ra
