transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/comparator.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/mux4.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/nzp_comparator.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/adder.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/mux2.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/lc3b_types.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/plus2.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/register.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/cache_control.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/data_membyte_filter.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/byte_select_mux2.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/array.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/cache_datapath.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/stb_filter.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/regfile_filter.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/zadj.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/zext.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/sext.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/adj.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/alu.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/control.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/datapath.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/gencc.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/ir.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/mp3.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/regfile.sv}

vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/physical_memory.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/mp3 {/home/syao6/ece411/mp3/mp3_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 200 ns
