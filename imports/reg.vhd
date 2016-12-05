LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY reg IS
	GENERIC (
		SIZE : NATURAL := 32
	);
	PORT
	(
	clk : IN std_logic;
	enable : IN std_logic;
	rst : IN std_logic;
	sr_in : IN std_logic_vector(SIZE - 1 DOWNTO 0);
	sr_out : OUT std_logic_vector(SIZE - 1 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE rtl OF reg IS
	CONSTANT ZERO : std_logic_vector(SIZE - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (rst = '1') THEN
				sr_out <= ZERO;
			ELSIF (enable = '1') THEN
				sr_out <= sr_in;
			END IF;
		END IF;
	END PROCESS;
END rtl;