-- Test bench FPGA

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.mips_pkg.all;

entity saida_display_tb is
end entity;

architecture test_bench of saida_display_tb is
	component saida_display is
		port
		(
			--SAIDAS PARA O TEST BENCH
			PC: out std_logic_vector(31 downto 0);
			RI: out std_logic_vector(31 downto 0);
			RDM: out std_logic_vector(31 downto 0);
			ULA: out std_logic_vector(31 downto 0);
			-- Fim de saidas para o TEST BENCH

			botao_clk: in STD_LOGIC;
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
	end component;
	SIGNAL sel: STD_LOGIC_vector(1 downto 0);
	SIGNAL botao_clk: STD_LOGIC:='1';
	SIGNAL clk_mem: STD_LOGIC := '1';
	SIGNAL botao_rst: STD_LOGIC;
	SIGNAL PC: std_logic_vector(31 downto 0);
	SIGNAL RI: std_logic_vector(31 downto 0);
	SIGNAL RDM: std_logic_vector(31 downto 0);
	SIGNAL ULA: std_logic_vector(31 downto 0);
	SIGNAL DISPLAY1	: std_logic_vector(6 downto 0);
	SIGNAL DISPLAY2	: std_logic_vector(6 downto 0);
	SIGNAL DISPLAY3	:  std_logic_vector(6 downto 0);
	SIGNAL DISPLAY4	:  std_logic_vector(6 downto 0);
	SIGNAL DISPLAY5	:  std_logic_vector(6 downto 0);
	SIGNAL DISPLAY6:  std_logic_vector(6 downto 0);
	SIGNAL DISPLAY7:  std_logic_vector(6 downto 0);
	SIGNAL DISPLAY8:  std_logic_vector(6 downto 0);
begin
teste1: saida_display
PORT MAP(PC => PC, RI => RI, RDM => RDM, ULA => ULA, botao_clk => botao_clk, clk_mem=>clk_mem, botao_rst => botao_rst, sel => sel, DISPLAY1 => DISPLAY1, DISPLAY2 => DISPLAY2, DISPLAY3 => DISPLAY3, DISPLAY4 => DISPLAY4, DISPLAY5 => DISPLAY5, DISPLAY6 => DISPLAY6, DISPLAY7 => DISPLAY7, DISPLAY8 => DISPLAY8);
-- PORT MAP(botao_clk => botao_clk, botao_rst => botao_rst, clk_mem => clk_mem, sel => sel, DISPLAY1 => DISPLAY1, DISPLAY2 => DISPLAY2, DISPLAY3 => DISPLAY3, DISPLAY4 => DISPLAY4, DISPLAY5 => DISPLAY5, DISPLAY6 => DISPLAY6, DISPLAY7 => DISPLAY7, DISPLAY8 => DISPLAY8);

inicio: process
begin
	sel <= "00";
	botao_rst <= '1';
	wait for 400 ps;
	botao_rst <= '0';
	-- Verificar se a saida deu 1000000, pois mostra zero no visor;
	-- Agora verificar a saida no display para o valor de RDM:
	wait for 1000 ps;
	sel <= "01";
	wait;
end process inicio;

clockp: process
begin
botao_clk <= not botao_clk;
wait for 200 ps;
end process clockp;

memclockp: process
begin
clk_mem   <= not clk_mem;
wait for 100 ps;
end process memclockp;


end architecture;
