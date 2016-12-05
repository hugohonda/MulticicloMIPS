
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.mips_pkg.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;
ENTITY mips_mem IS
	GENERIC (
		WIDTH : NATURAL := 32;
		WADDR : NATURAL := 8
	);
	PORT (
		address : IN STD_LOGIC_VECTOR (WADDR - 1 DOWNTO 0);
		clk : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
		wren : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE rtl OF mips_mem IS
	SIGNAL sub_wire0 : STD_LOGIC_VECTOR (31 DOWNTO 0);
	COMPONENT altsyncram
		GENERIC (
			clock_enable_input_a : STRING;
			clock_enable_output_a : STRING;
			init_file : STRING;
			intended_device_family : STRING;
			lpm_hint : STRING;
			lpm_type : STRING;
			numwords_a : NATURAL;
			operation_mode : STRING;
			outdata_aclr_a : STRING;
			outdata_reg_a : STRING;
			power_up_uninitialized : STRING;
			widthad_a : NATURAL;
			width_a : NATURAL;
			width_byteena_a : NATURAL
		);
		PORT (
			address_a : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock0 : IN STD_LOGIC;
			data_a : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren_a : IN STD_LOGIC;
			q_a : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	q <= sub_wire0;
	altsyncram_component : altsyncram
	GENERIC MAP(
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => "mem.mif",

		intended_device_family => "Cyclone II",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		lpm_type => "altsyncram",
		numwords_a => 256,
		operation_mode => "SINGLE_PORT",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "FALSE",
		widthad_a => 8,
		width_a => 32,
		width_byteena_a => 1
	)
	PORT MAP(
		address_a => address,
		clock0 => clk,
		data_a => data,
		wren_a => wren,
		q_a => sub_wire0
	);
END rtl;