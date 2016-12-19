library ieee;
use ieee.std_logic_1164.all;

entity hex7seg is
	port 
	(
		hex_in 			: in	std_logic_vector(3 downto 0);
		seven_out		: out	std_logic_vector(6 downto 0)
	);

end entity;

architecture rtl of hex7seg is

begin

	process (hex_in)
	begin
		case hex_in is
			when "0000" => seven_out <= "1000000";
			when "0001" => seven_out <= "1111001"; 
			when "0010" => seven_out <= "0100100";
			when "0011" => seven_out <= "0110000";
			
			when "0100" => seven_out <= "0011001";
			when "0101" => seven_out <= "0010010";
			when "0110" => seven_out <= "0000010";
			when "0111" => seven_out <= "1111000";
			
			when "1000" => seven_out <= "0000000";
			when "1001" => seven_out <= "0010000";
			when "1010" => seven_out <= "0001000";
			when "1011" => seven_out <= "0000011";
			
			when "1100" => seven_out <= "1000110";
			when "1101" => seven_out <= "0100001";
			when "1110" => seven_out <= "0000110";
			when "1111" => seven_out <= "0001110";
			when others => seven_out <= "1000000";
			end case;
	end process;

end rtl;
