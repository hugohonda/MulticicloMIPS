library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_pkg.all;

ENTITY mips_multiciclo_final IS
	PORT(
		--chaves: IN STD_LOGIC_VECTOR (12 downto 0);
		botao_clk: IN STD_LOGIC;
		botao_rst: IN STD_LOGIC;
		clk_mem	:	IN STD_LOGIC;
		saidaMips_PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		saidaMips_RI: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		saidaMips_RDM: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		saidaMips_ALU: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)	
	);
END ENTITY;

ARCHITECTURE mips_arch OF mips_multiciclo_final IS

	-- Sinais de PC
	SIGNAL entradaPC: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Entrada no registrador PC
	SIGNAL saidaPC: STD_LOGIC_VECTOR (31 DOWNTO 0); --Saida de PC
	SIGNAL writePC: STD_LOGIC; -- Sinal que recebe "EscrevePC or (zeroULA and EscrevePCCond)"
	SIGNAL PClast4: STD_LOGIC_VECTOR (3 DOWNTO 0); -- Ultimos 4 bits de PC para concatenar com immediate16<<2 e fazer o endereco de jump
	-- Fim sinais PC
	
	-- Sinais de Registrador de Instrucoes 
	SIGNAL saidaRI: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida do registrador RI
	SIGNAL opcode: STD_LOGIC_VECTOR (5 DOWNTO 0);	--
	SIGNAL rs: STD_LOGIC_VECTOR (4 DOWNTO 0);			--
	SIGNAL rt: STD_LOGIC_VECTOR (4 DOWNTO 0);			--
	SIGNAL rd: STD_LOGIC_VECTOR (4 DOWNTO 0);			--
	SIGNAL shamt: STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL funct: STD_LOGIC_VECTOR (5 DOWNTO 0);
	SIGNAL immediate16: STD_LOGIC_VECTOR (15 DOWNTO 0); 
	SIGNAL immediate26: STD_LOGIC_VECTOR (25 DOWNTO 0);
	-- Fim sinais RI
	
	-- Sinais da ULA
	SIGNAL resultadoULA: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida da ULA
	SIGNAL zeroULA: STD_LOGIC;
	SIGNAL entradaA_ULA: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL entradaB_ULA: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL overflow: STD_LOGIC;
	-- Fim de sinais da ULA
	
	-- Sinais auxiliares para MUX do Registrador Destino
	SIGNAL rt_aux:STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL rd_aux: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL shamt_aux: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL entrada_rd_aux: STD_LOGIC_VECTOR (31 DOWNTO 0);
	--Fim de regdst auxiliares
	
	SIGNAL saida_mem: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida de dados da memoria;
	SIGNAL endereco_in: STD_LOGIC_VECTOR (7 DOWNTO 0); -- Entrada de endereco na memoria
	SIGNAL endereco_in_aux: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Auxiliar que sai do MUX 
	SIGNAL saida_regA: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida do registrador A (entrada ulaA)
	SIGNAL saida_regB: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida do registrador B (entrada ulaB)
	SIGNAL saida_RDM: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL immediate32: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Imediato com extensas de sinal
	SIGNAL immediate32_sll2: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Imediato com extensao de sinal deslocado 2 bits para esquerda
	SIGNAL endereco_jump: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Endereco de jump
	SIGNAL endereco_jump_aux: STD_LOGIC_VECTOR (27 DOWNTO 0); -- Auxiliar para formar o endereco de jump
	SIGNAL saida_RegALU: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida do registrador SaidaULA
	SIGNAL entradaA_ULA_aux: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida do MUX_4 para entrada A da ULA
	
	-- Sinais Banco de Registradores
	SIGNAL entrada_rd: STD_LOGIC_VECTOR (4 DOWNTO 0); --Outras entradas do BREG vem direto de RI (sem necessidade de MUX
	SIGNAL entrada_dados_BReg: STD_LOGIC_VECTOR (31 DOWNTO 0); -- Saida do mux_RegDST e entrada de dados no BREG
	SIGNAL dados_leitura_1: STD_LOGIC_VECTOR (31 DOWNTO 0); -- saida 1 do breg
	SIGNAL dados_leitura_2: STD_LOGIC_VECTOR (31 DOWNTO 0); -- saida 2 do breg
	SIGNAL aluctl: STD_LOGIC_VECTOR (3 DOWNTO 0); -- saida 2 do breg
	
	--SINAL de TESTePC
	SIGNAL mout_PC: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--SINAIS unidade de controle
	
	SIGNAL sinal_cs: STD_LOGIC_VECTOR (3 DOWNTO 0); 	
	SIGNAL sinal_ns: STD_LOGIC_VECTOR (3 DOWNTO 0); 	
	SIGNAL sinal_branch: std_logic; 
	
	
	SIGNAL EscrevePCCond:  STD_LOGIC;
	SIGNAL EscrevePC:  STD_LOGIC;
	SIGNAL IouD:  STD_LOGIC;
	SIGNAL LeMem:  STD_LOGIC;
	SIGNAL EscreveMem:  STD_LOGIC;
	SIGNAL MemparaReg:  STD_LOGIC;
	SIGNAL EscreveIR:  STD_LOGIC;
	SIGNAL OrigPC:  STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL OpALU:  STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL OrigBALU:  STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL OrigAALU:  STD_LOGIC;
	SIGNAL EscreveReg:  STD_LOGIC;
	SIGNAL RegDst:  STD_LOGIC;
	SIGNAL is_beq, is_bne: STD_LOGIC;
	
	SIGNAL is_shift: STD_LOGIC;
	
--	SIGNAL not_clock:	STD_LOGIC;
	
-- Inicio do programa
	BEGIN

-- Saidas do mips:
saidaMips_ALU <= saida_RegALU;
saidaMips_RI <= saidaRI;
saidaMips_PC <= saidaPC;
saidaMips_RDM <= saida_RDM;

--Fim de saidas do MIPS

-- Clock de descida.
--clk_mem <= botao_clk after 10 ps;

writePC <= EscrevePC or ((zeroULA and is_beq) or (not(zeroULA) and is_bne));
PC: reg
		PORT MAP (
			clk => botao_clk,
			enable=> writePC,
			rst => botao_rst,
			sr_in=> entradaPC,
			sr_out=> saidaPC
		);
-- Atribuicao dos ultimos 4 bis:
PClast4 <= saidaPC(31 DOWNTO 28);

RI: reg32
		PORT MAP(
			clk => botao_clk,
			enable=> EscreveIR,
			sr_in=> saida_mem,
			sr_out=> saidaRI
		);
-- Atribuicao da saida de RI:
opcode <= saidaRI (31 DOWNTO 26);
rs <= saidaRI(25 DOWNTO 21);
rt <= saidaRI(20 DOWNTO 16);
rd <= saidaRI(15 DOWNTO 11);
shamt <= saidaRI(10 DOWNTO 6);
funct <= saidaRI(5 DOWNTO 0);
immediate16 <= saidaRI(15 DOWNTO 0);
immediate26 <= saidaRI(25 DOWNTO 0);

Reg_A: regbuf
		PORT MAP(botao_clk, dados_leitura_1, saida_regA);

Reg_B: regbuf
		PORT MAP(
			clk => botao_clk,
			sr_in=> dados_leitura_2,
			sr_out=> saida_regB
		);

R_SaidaAlu: regbuf
		PORT MAP(
			clk => botao_clk,
			sr_in=> resultadoULA,
			sr_out=> saida_RegALU
		);

R_DadosMem: regbuf
		PORT MAP(
			clk => botao_clk,
			sr_in => saida_mem,
			sr_out => saida_RDM
		);
		
Memoria: mips_mem
		PORT MAP(
			address => endereco_in,
			clk => clk_mem,
			data => saida_regB,
			wren => escreveMem,
			q => saida_mem
		);
BRegistradores: breg
		PORT MAP(
			clk => botao_clk,
			enable => EscreveReg,
			idxA => rs,
			idxB => rt,
			idxwr => entrada_rd,
			data_in => entrada_dados_BReg,
			regA => dados_leitura_1,
			regB => dados_leitura_2
		);

Extensao_Sinal: extsgn
		PORT MAP(
			input => immediate16,
			output => immediate32
		);
		
ULA: ulamips
		PORT MAP(
			aluctl => aluctl,
			A => entradaA_ULA,
			B => entradaB_ULA,
			aluout => resultadoULA,
			zero => zeroULA,
			ovfl => overflow
		);

MUX_Reg_destino: mux_2
		PORT MAP(
			in0 => rt_aux,
			in1 => rd_aux,
			sel => RegDst,
			m_out => entrada_rd_aux -- Saida do mux para registrador destino
		);
rt_aux <= "000000000000000000000000000"&rt;
rd_aux <= "000000000000000000000000000"&rd;
entrada_rd <= entrada_rd_aux(4 DOWNTO 0);

MUX_Dados_Escrita_BReg: mux_2
		PORT MAP(
			in0 => saida_RegALU,
			in1 => saida_RDM,
			sel => MemparaReg,
			m_out => entrada_dados_BReg
		);
		
MUX_OrigAALU: mux_2
		PORT MAP(
			in0 => saidaPC,
			in1 => saida_regA,
			sel => OrigAALU,
			m_out =>	entradaA_ULA_aux
		);

immediate32_sll2 <= immediate32(29 DOWNTO 0) & "00";

MUX_OrigBALU: mux_4
		PORT MAP(
			in0 => saida_regB,
			in1 => X"00000004",
			in2 => immediate32,
			in3 => immediate32_sll2,
			sel => OrigBALU,
			m_out =>	entradaB_ULA
		);

endereco_jump_aux <= immediate26(25 DOWNTO 0)&"00";
endereco_jump <= PClast4 & endereco_jump_aux;

MUX_OrigPC: mux_3
		PORT MAP(
			in0 => resultadoULA,
			in1 => saida_RegALU,
			in2 => endereco_jump,
			sel => OrigPC,
			m_out => entradaPC
		);

MUX_IouD: mux_2
		PORT MAP(
			in0 => saidaPC,
			in1 => saida_RegALU,
			sel => IouD,
			m_out => endereco_in_aux
		);
endereco_in <= endereco_in_aux(7 DOWNTO 0);

MUX_is_shift: mux_2
		PORT MAP(
			in0 => entradaA_ULA_aux,
			in1 => shamt_aux,
			sel => is_shift,
			m_out => entradaA_ULA
		);
shamt_aux <= X"000000" & "000" & shamt;


--ula_control: ULA_controle
--		PORT MAP(
--		funct => funct,
--		ULA_Op => OpALU,
--		saida => aluctl
--		);

ula_control: alu_ctr
		PORT MAP(OPALU, funct, aluctl, is_shift);
		
unidade_controle: mips_control
		PORT MAP( botao_clk, botao_rst, opcode, EscreveIR, EscrevePC, EscreveMem, is_beq, is_bne, MemparaReg, opALU, IouD, OrigPC, OrigAALU, OrigBALU, EscreveReg, RegDst);
		
		
--reg_state_register: regbuf_4
--		PORT MAP(
--		clk => botao_clk,
--		sr_in => sinal_ns,
--		sr_out => sinal_cs		
--		);
--		
--unidade_controle: CUnit
--		PORT MAP(
--		
--			OPC => OPCode,
--         CS =>sinal_cs,
--         ALUOp => OpALU,
--         ALUSrcB => OrigBALU,
--         ALUSrcA => OrigAALU,
--			PCSource => OrigPC,
--			PCWriteCond => EscrevePCCond,
--			PCwrite => EscrevePC,
--			IorD => IouD,
--			MemRead => LeMem,
--			MemWrite => EscreveMem,
--         MemtoReg => MemparaReg,
--			IRWrite => EscreveIR,
--			RegDst => RegDst,
--         RegWrite => EscreveReg,
--			NewS => sinal_ns,
--			Branchsignal => sinal_branch
--		);
--		
		


END ARCHITECTURE;

