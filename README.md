# Jogo Inspirado em Enduro de Atari

Este projeto foi desenvolvido como parte da disciplina de **Arquitetura de Computadores** no curso de **Análise e Desenvolvimento de Sistemas** do IFRN - Campus Natal Central (CNAT). O objetivo é aplicar conceitos de arquitetura de computadores simulando um jogo inspirado no clássico *Enduro* do Atari.

## Descrição do Projeto

O jogo simula uma corrida onde o jogador controla um carro na tela, desviando de obstáculos e mantendo o controle da posição. A implementação utiliza a arquitetura **MIPS** e a interação é feita com ferramentas de simulação fornecidas pelo ambiente.

## Como Executar

Siga os passos abaixo para configurar e executar o jogo:

### 1. Configuração do **Keyboard and Display MMIO Simulator**
1. Acesse **Tools** > **Keyboard and Display MMIO Simulator**.
2. Clique em **Connect to MIPS**.

   - O controle do carro será realizado pelas teclas:
     - **A**: Mover o carro para a esquerda.
     - **D**: Mover o carro para a direita.

### 2. Configuração do **Bitmap Display**
1. Acesse **Tools** > **Bitmap Display**.
2. Clique em **Connect to MIPS**.
3. Antes de conectar, configure os parâmetros da seguinte forma:
   - **Unit Width in Pixels**: `4`
   - **Unit Height in Pixels**: `2`
   - **Display Width in Pixels**: `512`
   - **Display Height in Pixels**: `256`

### 3. Execução do Jogo
- Após configurar as ferramentas, execute o código no simulador.
- Controle o carro utilizando as teclas **A** e **D**.

Pronto! Divirta-se jogando o clássico inspirado em *Enduro*!

## Tecnologias Utilizadas
- Arquitetura MIPS
- **Keyboard and Display MMIO Simulator**
- **Bitmap Display**

## Desenvolvido por
Luiz Felipe Pinheiro Lopes  
Discente do curso de **Análise e Desenvolvimento de Sistemas** - IFRN CNAT.

---

<div align="center">
 Divirta-se com o jogo!  
</div>
