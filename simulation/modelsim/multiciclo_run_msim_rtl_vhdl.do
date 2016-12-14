transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/MulticicloMIPS/imports/regbuf.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/reg.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/mips_pkg.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/mux_4.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/mux_3.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/mux_2_regdst.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/mux_2.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/memoria_mips.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/logextsgn.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/extsgn.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/controle_mips.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/banco_reg.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/alu_mips.vhd}
vcom -93 -work work {E:/MulticicloMIPS/imports/alu_controle.vhd}
vcom -93 -work work {E:/MulticicloMIPS/multiciclo.vhd}

vcom -93 -work work {E:/MulticicloMIPS/multiciclo_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  multiciclo_tb

add wave *
view structure
view signals
run 100 ns
