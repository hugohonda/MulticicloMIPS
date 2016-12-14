LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE work.mips_pkg.ALL;
ENTITY mux_2_regdst IS
	GENERIC (
		SIZE : NATURAL := 5
	);
	PORT (
		in0, in1 : IN std_logic_vector(SIZE - 1 DOWNTO 0);
		sel : IN std_logic;
		m_out : OUT std_logic_vector(SIZE - 1 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE rtl OF mux_2_regdst IS
BEGIN
	m_out <= in0 WHEN (sel = '0') ELSE in1;
END ARCHITECTURE;