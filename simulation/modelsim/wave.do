onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 /mp3_tb/clk
add wave -noupdate -height 15 /mp3_tb/instr_write
add wave -noupdate -height 15 /mp3_tb/instr_read
add wave -noupdate -height 15 /mp3_tb/instr_mem_byte_enable
add wave -noupdate -height 15 /mp3_tb/instr_address
add wave -noupdate -height 15 /mp3_tb/instr_rdata
add wave -noupdate -height 15 /mp3_tb/instr_wdata
add wave -noupdate -height 15 -label regfile -expand -subitemconfig {{/mp3_tb/dut/datapath_module/regfile_module/data[7]} {-height 15} {/mp3_tb/dut/datapath_module/regfile_module/data[6]} {-height 15} {/mp3_tb/dut/datapath_module/regfile_module/data[5]} {-height 15} {/mp3_tb/dut/datapath_module/regfile_module/data[4]} {-height 15} {/mp3_tb/dut/datapath_module/regfile_module/data[3]} {-height 15} {/mp3_tb/dut/datapath_module/regfile_module/data[2]} {-height 15} {/mp3_tb/dut/datapath_module/regfile_module/data[1]} {-height 15} {/mp3_tb/dut/datapath_module/regfile_module/data[0]} {-height 15}} /mp3_tb/dut/datapath_module/regfile_module/data
add wave -noupdate -height 15 -label ctrl -expand -subitemconfig {/mp3_tb/dut/datapath_module/control_rom_module/ctrl.opcode {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.aluop {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.load_pc {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.load_ir {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.load_regfile {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.load_mar {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.load_mdr {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.load_cc {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.regfile_filter_enable {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.stb_filter_enable {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.pcmux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.brmux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.storemux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.destmux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.alumux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.regfilemux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.marmux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.mdrmux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.offsetaddermux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.offset6mux_sel {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.mem_read {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.mem_write {-height 15} /mp3_tb/dut/datapath_module/control_rom_module/ctrl.mem_byte_enable {-height 15}} /mp3_tb/dut/datapath_module/control_rom_module/ctrl
add wave -noupdate -height 15 -label ctrl_exec -expand -subitemconfig {/mp3_tb/dut/datapath_module/ctrlword1/out.opcode {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.aluop {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.load_pc {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.load_ir {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.load_regfile {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.load_mar {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.load_mdr {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.load_cc {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.regfile_filter_enable {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.stb_filter_enable {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.pcmux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.brmux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.storemux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.destmux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.alumux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.regfilemux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.marmux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.mdrmux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.offsetaddermux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.offset6mux_sel {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.mem_read {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.mem_write {-height 15} /mp3_tb/dut/datapath_module/ctrlword1/out.mem_byte_enable {-height 15}} /mp3_tb/dut/datapath_module/ctrlword1/out
add wave -noupdate -height 15 -label ctrl_mem /mp3_tb/dut/datapath_module/ctrlword2/out
add wave -noupdate -height 15 -label ctrl_wr /mp3_tb/dut/datapath_module/ctrlword3/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {286233 ps}
