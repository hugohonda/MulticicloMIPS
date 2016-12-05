LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.mips_pkg.ALL;
ENTITY extsgn IS
	GENERIC (
		IN_SIZE : NATURAL := 16;
		OUT_SIZE : NATURAL := 32
	);
	PORT (
		input : IN std_logic_vector(IN_SIZE - 1 DOWNTO 0);
		output : OUT std_logic_vector(OUT_SIZE - 1 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE wires OF extsgn IS
	SIGNAL tmp : std_logic_vector(OUT_SIZE - 1 DOWNTO 0);
BEGIN
	output <= tmp;
	tmp(IN_SIZE - 1 DOWNTO 0) <= input;
	tmp(OUT_SIZE - 1 DOWNTO IN_SIZE) <= (OTHERS => input(IN_SIZE - 1));
END wires;