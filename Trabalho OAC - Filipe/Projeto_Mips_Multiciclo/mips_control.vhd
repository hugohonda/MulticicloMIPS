LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use work.mips_pkg.all;

ENTITY mips_control IS

	PORT
	(
		clk, rst	: IN std_logic;
		opcode	: IN std_logic_vector (5 DOWNTO 0);
		wr_ir		: OUT std_logic;
		wr_pc		: OUT std_logic;
		wr_mem	: OUT std_logic;
		is_beq	: OUT std_logic;
		is_bne	: OUT std_logic;
		s_datareg: OUT std_logic;
		op_alu	: OUT std_logic_vector (1 DOWNTO 0);
		s_mem_add: OUT std_logic;
		s_PCin	: OUT std_logic_vector (1 DOWNTO 0);
		s_aluAin : OUT std_logic;
		s_aluBin : OUT std_logic_vector (1 DOWNTO 0); 
		wr_breg	: OUT std_logic;
		s_reg_add: OUT std_logic
	);
	
END ENTITY;

ARCHITECTURE control_op OF mips_control IS

	type ctr_state is (fetch, decode, c_mem_add, readmem, ldreg, writemem, rtype_ex, writereg, writereg_i, branch_ex, jump_ex, addi_ex);

	signal pstate, nstate : ctr_state;

	BEGIN
	
reg: process(clk, rst)
	begin
		if (rst = '1') then 
			pstate <= fetch;
		elsif (rising_edge(clk)) then 
			pstate <= nstate;
		end if;
	end process;
		
logic: process (opcode, pstate)
	begin
		wr_ir			<= '0';
		wr_pc			<= '0';
		wr_mem		<= '0';
		wr_breg		<= '0';
		is_beq 		<= '0';
		is_bne 		<= '0';
		op_alu		<= "00";
		s_datareg 	<= '0';
		s_mem_add 	<= '0';
		s_PCin		<= "00";
		s_aluAin 	<= '0';
		s_aluBin  	<= "00";
		s_reg_add 	<= '0';
		case pstate is 
			when fetch => 	wr_pc 	<= '1';
								s_aluBin <= "01";
								wr_ir 	<= '1';
								
			when decode =>	s_aluBin <= "11";
								
			
			when c_mem_add => s_aluAin <= '1';
									s_aluBin <= "10";
										
			when readmem => s_mem_add <= '1';
								 
			when ldreg =>	s_datareg <= '1';
								wr_breg	 <= '1';
								
			when writemem => 	wr_mem 	 <= '1';
									s_mem_add <= '1';
								
			when addi_ex =>	s_aluAin <= '1';
									s_aluBin <= "10";
									
			when rtype_ex => 	s_aluAin <= '1';
									op_alu <= "10";
									
			when writereg => s_reg_add <= '1';
								  wr_breg <= '1';
			
			when writereg_i =>	s_reg_add <= '0';
										wr_breg <= '1';
								  
			when branch_ex => s_aluAin <= '1';
									op_alu <= "01";
									s_PCin <= "01";
									if opcode = iBEQ 
									then is_beq <= '1';
									else is_bne <= '1';
									end if;
									
			when jump_ex =>	s_PCin <= "10";
									wr_pc <= '1';
		end case;
	end process;
	
new_state: process (opcode, pstate)
		begin
		
			nstate <= fetch;
			
			case pstate is
			when fetch => 	nstate <= decode;
			when decode =>	case opcode is
								when iADDI => nstate <= addi_ex;
								when iRTYPE => nstate <= rtype_ex;
								when iLW | iSW => nstate <= c_mem_add;
								when iBEQ | iBNE => nstate <= branch_ex;
								when iJ => nstate <= jump_ex;
								when others => null;
								end case;
			when c_mem_add => if opcode = iLW 
									then nstate <= readmem;
									else nstate <= writemem;
									end if;
			when readmem => nstate <= ldreg;
			when rtype_ex => nstate <= writereg;
			when addi_ex => nstate <= writereg_i;
			when others => null;
			end case;
		end process;
		
end control_op;
				
	