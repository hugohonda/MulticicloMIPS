LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.mips_pkg.ALL;
ENTITY alu_ctr IS
	PORT
	(
	op_alu : IN std_logic_vector(2 DOWNTO 0);
	funct : IN std_logic_vector(5 DOWNTO 0);
	alu_ctr : OUT std_logic_vector(3 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE behav OF alu_ctr IS
BEGIN
	alu_ctr <= ULA_AND WHEN (op_alu = "010" AND funct = iAND) ELSE
	           ULA_OR WHEN (op_alu = "010" AND funct = iOR) ELSE
	           ULA_XOR WHEN (op_alu = "010" AND funct = iXOR) ELSE
	           ULA_SLL WHEN (op_alu = "010" AND funct = iSLL) ELSE
	           ULA_SRA WHEN (op_alu = "010" AND funct = iSRA) ELSE
	           ULA_SRL WHEN (op_alu = "010" AND funct = iSRL) ELSE
	           ULA_ADD WHEN (op_alu = "010" AND funct = iADD) ELSE
	           ULA_ADD WHEN (op_alu = "000") ELSE
	           ULA_SUB WHEN (op_alu = "010" AND funct = iSUB) ELSE
	           ULA_SUB WHEN (op_alu = "001") ELSE
	           ULA_SLT WHEN (op_alu = "010" AND funct = iSLT) ELSE
	           ULA_NOR WHEN (op_alu = "010" AND funct = iNOR) ELSE
	           ULA_OR WHEN (op_alu = "100") ELSE
	           ULA_NOP;
END ARCHITECTURE;