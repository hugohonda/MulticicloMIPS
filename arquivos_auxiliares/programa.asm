.data

.text
# andi
addi  $t0, $zero, 4
andi $t1, $t0, 12
addi  $t2, $t1, 4

# ori
#addi  $t0, $zero, 4
#ori  $t1, $t0, 2
#addi  $t2, $t1, 4

# sll
#addi  $t0, $zero, 4
#sll $t1, $t0, 1
#addi  $t2, $t1, 4
   
# srl
#addi  $t0, $zero, 4
#srl $t1, $t0, 1
#addi  $t0, $zero, 4
   
# bgez tomado
#addi  $t0, $zero, 4
#bgez $t0,label3
#label1:
#addi  $t0, $zero, 1
#label2:
#addi  $t0, $zero, 2
#label3:
#addi  $t0, $zero, 3
    
# bgez nao tomado
#addi  $t0, $zero, -1
#bgez $t0,label3
#label1:
#addi  $t0, $zero, 1
#label2:
#addi  $t0, $zero, 2
#label3:
#addi  $t0, $zero, 3
    
# bltz tomado
#addi  $t0, $zero, -1
#bltz $t0,label3
#label1:
#addi  $t0, $zero, 1
#label2:
#addi  $t0, $zero, 2
#label3:
#addi  $t0, $zero, 3
    
# bltz nao tomado
#addi  $t0, $zero, 4
#bltz $t0,label3
#label1:
#addi  $t0, $zero, 1
#label2:
#addi  $t0, $zero, 2
#label3:
#addi  $t0, $zero, 3
    
# slti
#slti $t1, $t0, 2
#slti $t2, $t1, 0
#addi $t3, $t2, 1
