-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "12/15/2015 23:30:56"
                                                            
-- Vhdl Test Bench template for design  :  processador
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY processador_tb IS
END processador_tb;
ARCHITECTURE processador_arch OF processador_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL tb_pc_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_alu_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL tb_funct : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL tb_breg_out_a_aux : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_breg_out_b_aux : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_shamt : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL tb_imm_signalextend_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_alu_a_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_alu_b_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_alu_ctrl_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL tb_alu_out_buf : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_bgez_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_bltz_temp : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_decode_inst_mem : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_imm_signalextend_shiffted_temp : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_inst_mem_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL tb_inst_mem_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_log_imm_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_logical_sel : STD_LOGIC;
SIGNAL tb_mem_para_reg_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_op_alu : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL tb_s_aluAin : STD_LOGIC;
SIGNAL tb_s_aluBin : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL tb_s_datareg : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL tb_s_is_bgez : STD_LOGIC;
SIGNAL tb_s_log_imm : STD_LOGIC;
SIGNAL tb_s_Pcin : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL tb_wr_breg : STD_LOGIC;
SIGNAL tb_wr_ir : STD_LOGIC;
SIGNAL rst : STD_LOGIC;
COMPONENT processador
	PORT (
	clk : IN STD_LOGIC;
	rst : IN STD_LOGIC;
	tb_alu_a_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_alu_b_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_alu_ctrl_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	tb_alu_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_alu_out_buf : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_bgez_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_bltz_temp : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_breg_out_a_aux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_breg_out_b_aux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_decode_inst_mem : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_funct : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	tb_imm_signalextend_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_imm_signalextend_shiffted_temp : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_inst_mem_in : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	tb_inst_mem_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_log_imm_mux_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_logical_sel : OUT STD_LOGIC;
	tb_mem_para_reg_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_op_alu : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	tb_opcode : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	tb_pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	tb_s_aluAin : OUT STD_LOGIC;
	tb_s_aluBin : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	tb_s_datareg : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	tb_s_is_bgez : OUT STD_LOGIC;
	tb_s_log_imm : OUT STD_LOGIC;
	tb_s_Pcin : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	tb_shamt : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	tb_wr_breg : OUT STD_LOGIC;
	tb_wr_ir : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : processador
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	rst => rst,
	tb_alu_a_in => tb_alu_a_in,
	tb_alu_b_in => tb_alu_b_in,
	tb_alu_ctrl_out => tb_alu_ctrl_out,
	tb_alu_out => tb_alu_out,
	tb_alu_out_buf => tb_alu_out_buf,
	tb_bgez_out => tb_bgez_out,
	tb_bltz_temp => tb_bltz_temp,
	tb_breg_out_a_aux => tb_breg_out_a_aux,
	tb_breg_out_b_aux => tb_breg_out_b_aux,
	tb_decode_inst_mem => tb_decode_inst_mem,
	tb_funct => tb_funct,
	tb_imm_signalextend_out => tb_imm_signalextend_out,
	tb_imm_signalextend_shiffted_temp => tb_imm_signalextend_shiffted_temp,
	tb_inst_mem_in => tb_inst_mem_in,
	tb_inst_mem_out => tb_inst_mem_out,
	tb_log_imm_mux_out => tb_log_imm_mux_out,
	tb_logical_sel => tb_logical_sel,
	tb_mem_para_reg_out => tb_mem_para_reg_out,
	tb_op_alu => tb_op_alu,
	tb_opcode => tb_opcode,
	tb_pc_out => tb_pc_out,
	tb_s_aluAin => tb_s_aluAin,
	tb_s_aluBin => tb_s_aluBin,
	tb_s_datareg => tb_s_datareg,
	tb_s_is_bgez => tb_s_is_bgez,
	tb_s_log_imm => tb_s_log_imm,
	tb_s_Pcin => tb_s_Pcin,
	tb_shamt => tb_shamt,
	tb_wr_breg => tb_wr_breg,
	tb_wr_ir => tb_wr_ir
	);
clock_process: process
	begin
		clk <= '0';
		wait for 10 ps;
		clk <= '1';
		wait for 10 ps;
	end process;
processador_process: process
variable i : integer := 0;
	begin
			rst <= '1';
			wait for 20 ps;
			rst <= '0';
			wait;
	end process;                                    
END processador_arch;
