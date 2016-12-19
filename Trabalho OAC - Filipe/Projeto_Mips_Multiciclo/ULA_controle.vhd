library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_pkg.all;


entity ULA_controle is

	port 
	(
		funct	   : in std_logic_vector	(5 downto 0);
		ULA_Op	   : in std_logic_vector	(1 downto 0);
		saida : out std_logic_vector (3 downto 0)
	);

end entity;

architecture rtl of ULA_controle is
begin

	process1: process(funct, ULA_Op)
	begin
	
	case ULA_Op is
	when "00" =>
	saida <= "0010";
	when "01" =>
	saida <= "0110";
	when "10" =>
		case funct is
		when "100000" =>
		saida <= "0010";
		when "100010" =>
		saida <= "0110";
		when "100100" =>
		saida <= "0000";
		when "100101" =>
		saida <= "0001";
		when "101010" =>
		saida <= "0111"; 
		when others => saida <= "0010";
		end case;
	when others => saida <= "0010";
	end case;
	
	end process;

end rtl;
