LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE work.mips_pkg.ALL;
ENTITY mux_4 IS
	GENERIC (
		W_SIZE : NATURAL := 32
	);
	PORT (
		in0, in1, in2, in3 : IN std_logic_vector(W_SIZE - 1 DOWNTO 0);
		sel : IN std_logic_vector(1 DOWNTO 0);
		m_out : OUT std_logic_vector(W_SIZE - 1 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE rtl OF mux_4 IS
BEGIN
	m_out <= in0 WHEN (sel = "00") ELSE
	         in1 WHEN (sel = "01") ELSE
	         in2 WHEN (sel = "10") ELSE
	         in3;
END ARCHITECTURE;