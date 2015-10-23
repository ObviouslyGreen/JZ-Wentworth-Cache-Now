transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/reg_latch.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/mux4.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/nzp_comparator.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/adder.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/mux2.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/lc3b_types.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/plus2.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/register.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/ctrl_register.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/control_rom.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/stb_filter.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/regfile_filter.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/zadj.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/zext.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/sext.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/adj.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/alu.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/datapath.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/gencc.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/ir.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/mp3.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/regfile.sv}

vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/mp3_tb.sv}
vlog -sv -work work +incdir+/home/syao6/ece411/J.Z.-Wentworth-Cache-Now {/home/syao6/ece411/J.Z.-Wentworth-Cache-Now/magic_memory_dp.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 200 ns
