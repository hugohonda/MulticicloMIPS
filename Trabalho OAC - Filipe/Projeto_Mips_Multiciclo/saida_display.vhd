-- Para ser implementado na FPGA!

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.mips_pkg.all;


entity saida_display is
	port
	(
		--SAIDAS PARA O TEST BENCH
		PC: out std_logic_vector(31 downto 0);
		RI: out std_logic_vector(31 downto 0);
		RDM: out std_logic_vector(31 downto 0);
		ULA: out std_logic_vector(31 downto 0);
		-- Fim de saidas para o TEST BENCH

		botao_clk: IN STD_LOGIC;
		botao_rst: in STD_LOGIC;
		clk_mem	: in STD_LOGIC;
		sel		: in std_logic_vector(1 downto 0);
		DISPLAY1	: out std_logic_vector(6 downto 0);
		DISPLAY2	: out std_logic_vector(6 downto 0);
		DISPLAY3	: out std_logic_vector(6 downto 0);
		DISPLAY4	: out std_logic_vector(6 downto 0);
		DISPLAY5	: out std_logic_vector(6 downto 0);
		DISPLAY6	: out std_logic_vector(6 downto 0);
		DISPLAY7	: out std_logic_vector(6 downto 0);
		DISPLAY8	: out std_logic_vector(6 downto 0)
	);
end entity;

architecture rtl of saida_display is
	COMPONENT mips_multiciclo_final IS
		PORT(
			botao_clk: IN STD_LOGIC;
			botao_rst: IN STD_LOGIC;
			clk_mem	: IN STD_LOGIC;
			saidaMips_PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			saidaMips_RI: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			saidaMips_RDM: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			saidaMips_ALU: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL PC_in: std_logic_vector(31 downto 0);
	SIGNAL RI_in: std_logic_vector(31 downto 0);
	SIGNAL RDM_in: std_logic_vector(31 downto 0);
	SIGNAL ULA_in: std_logic_vector(31 downto 0);

	SIGNAL HEX_aux: std_logic_vector(31 downto 0);
	SIGNAL HEX1: std_logic_vector(3 downto 0);
	SIGNAL HEX2: std_logic_vector(3 downto 0);
	SIGNAL HEX3: std_logic_vector(3 downto 0);
	SIGNAL HEX4: std_logic_vector(3 downto 0);
	SIGNAL HEX5: std_logic_vector(3 downto 0);
	SIGNAL HEX6: std_logic_vector(3 downto 0);
	SIGNAL HEX7: std_logic_vector(3 downto 0);
	SIGNAL HEX8: std_logic_vector(3 downto 0);

begin
-- Sinais para o TestBench

PC <= PC_in;
RI <= RI_in;
RDM <= RDM_in;
ULA <= ULA_in;

procesador: mips_multiciclo_final
		PORT MAP(
			botao_clk => botao_clk,
			botao_rst => botao_rst,
			clk_mem => clk_mem,
			saidaMips_PC => PC_in,
			saidaMips_RI => RI_in,
			saidaMips_RDM => RDM_in,
			saidaMips_ALU => ULA_in
		);

mux_visualizar_saida: mux_4
		PORT MAP(
			in0 => PC_in,
			in1 => RDM_in,
			in2 => ULA_in,
			in3 => RI_in,
			sel => sel,
			m_out =>	HEX_aux
		);

	HEX1 <= HEX_aux(3 downto 0);
	HEX2 <= HEX_aux(7 downto 4);
	HEX3 <= HEX_aux(11 downto 8);
	HEX4 <= HEX_aux(15 downto 12);
	HEX5 <= HEX_aux(19 downto 16);
	HEX6 <= HEX_aux(23 downto 20);
	HEX7 <= HEX_aux(27 downto 24);
	HEX8 <= HEX_aux(31 downto 28);

display_1: hex7seg
		PORT MAP(
			hex_in => HEX1,
			seven_out => DISPLAY1
		);
display_2: hex7seg
		PORT MAP(
			hex_in => HEX2,
			seven_out => DISPLAY2
		);
display_3: hex7seg
		PORT MAP(
			hex_in => HEX3,
			seven_out => DISPLAY3
		);
display_4: hex7seg
		PORT MAP(
			hex_in => HEX4,
			seven_out => DISPLAY4
		);
display_5: hex7seg
		PORT MAP(
			hex_in => HEX5,
			seven_out => DISPLAY5
		);
display_6: hex7seg
		PORT MAP(
			hex_in => HEX6,
			seven_out => DISPLAY6
		);
display_7: hex7seg
		PORT MAP(
			hex_in => HEX7,
			seven_out => DISPLAY7
		);
display_8: hex7seg
		PORT MAP(
			hex_in => HEX8,
			seven_out => DISPLAY8
		);


end architecture;
