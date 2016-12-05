LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE work.mips_pkg.ALL;
ENTITY mem_addr IS
	GENERIC (
		SIZE : NATURAL := 32;
		IMEM_ADDR : NATURAL := 8
	);
	PORT (
		in0, in1 : IN std_logic_vector(SIZE - 1 DOWNTO 0);
		sel : IN std_logic;
		m_out : OUT std_logic_vector(IMEM_ADDR - 1 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE rtl OF mem_addr IS
BEGIN
	m_out <= in0(7 DOWNTO 0) WHEN (sel = '0') ELSE in1(7 DOWNTO 0);
END ARCHITECTURE;