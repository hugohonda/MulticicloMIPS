transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/regbuf.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/reg.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/mips_pkg.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/registerbank.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/ulamips.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/mux_4.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/mux_3.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/mux_2_regdst.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/mux_2.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/mips_mem.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/mips_control.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/logextsgn.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/extsgn.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/imports/alu_control.vhd}
vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/processador.vhd}

vcom -93 -work work {//vmware-host/Shared Folders/Desktop/FINAL FINAL/Projeto_Final_OAC/processador_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  processador_tb

add wave *
view structure
view signals
run 100 ns
