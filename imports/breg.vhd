LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.mips_pkg.ALL;
ENTITY breg IS
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
END ENTITY;
ARCHITECTURE rtl OF breg IS
	SIGNAL breg32 : word_array(31 DOWNTO 0);
BEGIN
	regA <= ZERO32 WHEN (idxA = "00000") ELSE breg32(conv_integer(idxA));
	regB <= ZERO32 WHEN (idxB = "00000") ELSE breg32(conv_integer(idxB));
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (enable = '1') THEN
				breg32(conv_integer(idxwr)) <= data_in;
			END IF;
		END IF;
	END PROCESS;
END rtl;