LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
PACKAGE mips_pkg IS
	TYPE word_array IS ARRAY (NATURAL RANGE <> ) OF std_logic_vector(31 DOWNTO 0);
	CONSTANT IMEM_SIZE : INTEGER := 1024;
	CONSTANT IMEM_ADDR : INTEGER := 8;
	CONSTANT WORD_SIZE : NATURAL := 32;
	CONSTANT BREG_IDX : NATURAL := 5;
	CONSTANT ZERO32 : std_logic_vector(WORD_SIZE - 1 DOWNTO 0) := (OTHERS => '0');
	CONSTANT INC_PC : std_logic_vector(WORD_SIZE - 1 DOWNTO 0) := (2 => '1', OTHERS => '0');
	CONSTANT iRTYPE : std_logic_vector(5 DOWNTO 0) := "000000";
	CONSTANT iLW : std_logic_vector(5 DOWNTO 0) := "100011";
	CONSTANT iSW : std_logic_vector(5 DOWNTO 0) := "101011";
	CONSTANT iADDI : std_logic_vector(5 DOWNTO 0) := "001000";
	CONSTANT iORI : std_logic_vector(5 DOWNTO 0) := "001101";
	CONSTANT iANDI : std_logic_vector(5 DOWNTO 0) := "001100";
	CONSTANT iJ : std_logic_vector(5 DOWNTO 0) := "000010";
	CONSTANT iBEQ : std_logic_vector(5 DOWNTO 0) := "000100";
	CONSTANT iBNE : std_logic_vector(5 DOWNTO 0) := "000101";
	CONSTANT iBGEZ : std_logic_vector(5 DOWNTO 0) := "000001";
	CONSTANT iBLTZ : std_logic_vector(5 DOWNTO 0) := "000001";
	CONSTANT iSLTI : std_logic_vector(5 DOWNTO 0) := "001010";
	CONSTANT iADD : std_logic_vector(5 DOWNTO 0) := "100000";
	CONSTANT iSUB : std_logic_vector(5 DOWNTO 0) := "100010";
	CONSTANT iAND : std_logic_vector(5 DOWNTO 0) := "100100";
	CONSTANT iOR : std_logic_vector(5 DOWNTO 0) := "100101";
	CONSTANT iXOR : std_logic_vector(5 DOWNTO 0) := "100110";
	CONSTANT iNOR : std_logic_vector(5 DOWNTO 0) := "100111";
	CONSTANT iSLT : std_logic_vector(5 DOWNTO 0) := "101010";
	CONSTANT iSLL : std_logic_vector(5 DOWNTO 0) := "000000";
	CONSTANT iSRL : std_logic_vector(5 DOWNTO 0) := "000010";
	CONSTANT iSRA : std_logic_vector(5 DOWNTO 0) := "000011";
	CONSTANT ULA_ADD : std_logic_vector(3 DOWNTO 0) := "0010";
	CONSTANT ULA_SUB : std_logic_vector(3 DOWNTO 0) := "0110";
	CONSTANT ULA_AND : std_logic_vector(3 DOWNTO 0) := "0000";
	CONSTANT ULA_OR : std_logic_vector(3 DOWNTO 0) := "0001";
	CONSTANT ULA_XOR : std_logic_vector(3 DOWNTO 0) := "1001";
	CONSTANT ULA_NOP : std_logic_vector(3 DOWNTO 0) := "1111";
	CONSTANT ULA_NOR : std_logic_vector(3 DOWNTO 0) := "1100";
	CONSTANT ULA_SLT : std_logic_vector(3 DOWNTO 0) := "0111";
	CONSTANT ULA_SLL : std_logic_vector(3 DOWNTO 0) := "1000";
	CONSTANT ULA_SRL : std_logic_vector(3 DOWNTO 0) := "0011";
	CONSTANT ULA_SRA : std_logic_vector(3 DOWNTO 0) := "0101";
	COMPONENT mips_multi IS
		PORT
		(
		clk : IN std_logic;
		clk_rom : IN std_logic;
		rst : IN std_logic;
		debug : IN std_logic_vector(1 DOWNTO 0);
		data : OUT std_logic_vector(WORD_SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT reg IS
		GENERIC (
			SIZE : NATURAL := 32
		);
		PORT
		(
		clk : IN std_logic;
		enable : IN std_logic;
		rst : IN std_logic;
		sr_in : IN std_logic_vector(WORD_SIZE - 1 DOWNTO 0);
		sr_out : OUT std_logic_vector(WORD_SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT regbuf IS
		GENERIC (
			SIZE : NATURAL := 32
		);
		PORT
		(
		clk : IN std_logic;
		sr_in : IN std_logic_vector(SIZE - 1 DOWNTO 0);
		sr_out : OUT std_logic_vector(SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mem_addr IS
		GENERIC (
			SIZE : NATURAL := 32
		);
		PORT (
			in0, in1 : IN std_logic_vector(SIZE - 1 DOWNTO 0);
			sel : IN std_logic;
			m_out : OUT std_logic_vector(IMEM_ADDR - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux_2 IS
		GENERIC (
			SIZE : NATURAL := 32
		);
		PORT (
			in0, in1 : IN std_logic_vector(SIZE - 1 DOWNTO 0);
			sel : IN std_logic;
			m_out : OUT std_logic_vector(SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux_2_regdst IS
		GENERIC (
			SIZE : NATURAL := 5
		);
		PORT (
			in0, in1 : IN std_logic_vector(SIZE - 1 DOWNTO 0);
			sel : IN std_logic;
			m_out : OUT std_logic_vector(SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux_3 IS
		GENERIC (
			W_SIZE : NATURAL := 32
		);
		PORT (
			in0, in1, in2 : IN std_logic_vector(W_SIZE - 1 DOWNTO 0);
			sel : IN std_logic_vector(1 DOWNTO 0);
			m_out : OUT std_logic_vector(W_SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux_4 IS
		GENERIC (
			W_SIZE : NATURAL := 32
		);
		PORT (
			in0, in1, in2, in3 : IN std_logic_vector(W_SIZE - 1 DOWNTO 0);
			sel : IN std_logic_vector(1 DOWNTO 0);
			m_out : OUT std_logic_vector(W_SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT adder IS
		GENERIC (
			DATA_WIDTH : NATURAL := WORD_SIZE
		);
		PORT (
			a : IN std_logic_vector ((DATA_WIDTH - 1) DOWNTO 0);
			b : IN std_logic_vector ((DATA_WIDTH - 1) DOWNTO 0);
			res : OUT std_logic_vector ((DATA_WIDTH - 1) DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT inst_mem IS
		GENERIC (
			WIDTH : NATURAL := WORD_SIZE;
			WADDR : NATURAL := 8
		);
		PORT (
			address : IN STD_LOGIC_VECTOR (WADDR - 1 DOWNTO 0);
			clk : IN STD_LOGIC;
			data : IN STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
			wren : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT alu_mips IS
		PORT (
			aluctl : IN std_logic_vector(3 DOWNTO 0);
			A, B : IN std_logic_vector(WORD_SIZE - 1 DOWNTO 0);
			aluout : OUT std_logic_vector(WORD_SIZE - 1 DOWNTO 0);
			zero : OUT std_logic
		);
	END COMPONENT;
	COMPONENT alu_ctr IS
		PORT (
			op_alu : IN std_logic_vector(1 DOWNTO 0);
			funct : IN std_logic_vector(5 DOWNTO 0);
			alu_ctr : OUT std_logic_vector(3 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT controle_mips IS
		PORT
		(
		clk, rst : IN std_logic;
		opcode : IN std_logic_vector (5 DOWNTO 0);
		wr_ir : OUT std_logic;
		wr_pc : OUT std_logic;
		wr_mem : OUT std_logic;
		is_beq : OUT std_logic;
		is_bne : OUT std_logic;
		s_datareg : OUT std_logic_vector (1 DOWNTO 0);
		op_alu : OUT std_logic_vector (2 DOWNTO 0);
		s_mem_add : OUT std_logic;
		s_PCin : OUT std_logic_vector (1 DOWNTO 0);
		s_aluAin : OUT std_logic;
		s_aluBin : OUT std_logic_vector (1 DOWNTO 0);
		wr_breg : OUT std_logic;
		s_reg_add : OUT std_logic;
		s_log_imm : OUT std_logic;
		s_is_bgez : OUT std_logic
		);
	END COMPONENT;
	COMPONENT control IS
		PORT (
			opcode : IN std_logic_vector(5 DOWNTO 0);
			op_ula : OUT std_logic_vector(1 DOWNTO 0);
			reg_dst,
			rd_mem,
			branch,
			jump,
			mem2reg,
			mem_wr,
			alu_src,
			breg_wr : OUT std_logic
		);
	END COMPONENT;
	COMPONENT extsgn IS
		GENERIC (
			IN_SIZE : NATURAL := 16;
			OUT_SIZE : NATURAL := 32
		);
		PORT (
			input : IN std_logic_vector(IN_SIZE - 1 DOWNTO 0);
			output : OUT std_logic_vector(OUT_SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT logextsgn IS
		GENERIC (
			IN_SIZE : NATURAL := 16;
			OUT_SIZE : NATURAL := 32
		);
		PORT (
			input : IN std_logic_vector(IN_SIZE - 1 DOWNTO 0);
			output : OUT std_logic_vector(OUT_SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT sig_ext IS
		PORT (
			imm16 : IN std_logic_vector(WORD_SIZE/2 - 1 DOWNTO 0);
			ext32 : OUT std_logic_vector(WORD_SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT memoria_mips IS
		GENERIC (
			WIDTH : NATURAL := 32;
			WADDR : NATURAL := IMEM_ADDR
		);
		PORT (
			address : IN STD_LOGIC_VECTOR (WADDR - 1 DOWNTO 0);
			clk : IN STD_LOGIC;
			data : IN STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
			wren : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT data_mem IS
		PORT
		(
		address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT banco_reg IS
		GENERIC (
			SIZE : NATURAL := 32;
			ADDR : NATURAL := 5
		);
		PORT
		(
		clk : IN std_logic;
		enable : IN std_logic;
		idxA : IN std_logic_vector(ADDR - 1 DOWNTO 0);
		idxB : IN std_logic_vector(ADDR - 1 DOWNTO 0);
		idxwr : IN std_logic_vector(ADDR - 1 DOWNTO 0);
		data_in : IN std_logic_vector(SIZE - 1 DOWNTO 0);
		regA : OUT std_logic_vector(SIZE - 1 DOWNTO 0);
		regB : OUT std_logic_vector(SIZE - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT alu_controle IS
		PORT
		(
		op_alu : IN std_logic_vector(2 DOWNTO 0);
		funct : IN std_logic_vector(5 DOWNTO 0);
		alu_ctr : OUT std_logic_vector(3 DOWNTO 0);
		logical_sel : OUT std_logic
		);
	END COMPONENT;
END mips_pkg;
PACKAGE BODY mips_pkg IS
	PROCEDURE mux2x1 (
		SIGNAL x0, x1 : IN std_logic_vector(WORD_SIZE - 1 DOWNTO 0);
	SIGNAL sel : IN std_logic;
SIGNAL z : OUT std_logic_vector(WORD_SIZE - 1 DOWNTO 0) ) IS
BEGIN
	IF (sel = '1') THEN
		z <= x1;
	ELSE
		z <= x0;
	END IF;
END PROCEDURE;
END mips_pkg;
