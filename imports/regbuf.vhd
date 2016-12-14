LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY regbuf IS
	GENERIC (
		SIZE : NATURAL := 32
	);
	PORT
	(
	clk : IN std_logic;
	sr_in : IN std_logic_vector(SIZE - 1 DOWNTO 0);
	sr_out : OUT std_logic_vector(SIZE - 1 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE rtl OF regbuf IS
BEGIN
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			sr_out <= sr_in;
		END IF;
	END PROCESS;
END rtl;