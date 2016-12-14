LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.mips_pkg.ALL;
ENTITY alu_mips IS
	GENERIC (
		SIZE : NATURAL := 32
	);
	PORT (
		aluctl : IN std_logic_vector(3 DOWNTO 0);
		A, B : IN std_logic_vector(SIZE - 1 DOWNTO 0);
		aluout : OUT std_logic_vector(SIZE - 1 DOWNTO 0);
		zero : OUT std_logic
	);
END alu_mips;
ARCHITECTURE behavioral OF alu_mips IS
	SIGNAL tmp : std_logic_vector(SIZE - 1 DOWNTO 0);
	SIGNAL a32 : std_logic_vector(SIZE - 1 DOWNTO 0);
BEGIN
	tmp <= std_logic_vector(signed(A) - signed(B));
	aluout <= a32;
	zero <= '1' WHEN (a32 = ZERO32) ELSE '0';
	ula : PROCESS (A, B, aluctl, a32, tmp)
	BEGIN
		CASE aluctl IS
			WHEN ULA_AND => a32 <= (A AND B);
			WHEN ULA_OR => a32 <= (A OR B);
			WHEN ULA_NOR => a32 <= (A NOR B);
			WHEN ULA_XOR => a32 <= (A XOR B);
			WHEN ULA_ADD => a32 <= std_logic_vector(signed(A) + signed(B));
			WHEN ULA_SUB => a32 <= std_logic_vector(signed(A) - signed(B));
			WHEN ULA_SLT => a32 <= (0 => tmp(SIZE - 1), OTHERS => '0');
			WHEN ULA_SLL => a32 <= std_logic_vector(unsigned(B) SLL to_integer(signed(A)));
			WHEN ULA_SRL => a32 <= std_logic_vector(unsigned(B) SRL to_integer(signed(A)));
			WHEN OTHERS => a32 <= (OTHERS => '0');
		END CASE;
	END PROCESS;
END ARCHITECTURE behavioral;
