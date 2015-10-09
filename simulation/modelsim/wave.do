onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/clk
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/datapath_module/pc_out
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_address
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_read
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_rdata
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_write
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/mem_byte_enable
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_wdata
add wave -noupdate -height 15 -radix hexadecimal -childformat {{{/mp2_tb/dut/datapath_module/regfile_module/data[7]} -radix hexadecimal} {{/mp2_tb/dut/datapath_module/regfile_module/data[6]} -radix hexadecimal} {{/mp2_tb/dut/datapath_module/regfile_module/data[5]} -radix hexadecimal} {{/mp2_tb/dut/datapath_module/regfile_module/data[4]} -radix hexadecimal} {{/mp2_tb/dut/datapath_module/regfile_module/data[3]} -radix hexadecimal} {{/mp2_tb/dut/datapath_module/regfile_module/data[2]} -radix hexadecimal} {{/mp2_tb/dut/datapath_module/regfile_module/data[1]} -radix hexadecimal} {{/mp2_tb/dut/datapath_module/regfile_module/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp2_tb/dut/datapath_module/regfile_module/data[7]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/datapath_module/regfile_module/data[6]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/datapath_module/regfile_module/data[5]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/datapath_module/regfile_module/data[4]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/datapath_module/regfile_module/data[3]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/datapath_module/regfile_module/data[2]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/datapath_module/regfile_module/data[1]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/datapath_module/regfile_module/data[0]} {-height 15 -radix hexadecimal}} /mp2_tb/dut/datapath_module/regfile_module/data
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/pmem_address
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/pmem_read
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/pmem_rdata
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/pmem_write
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/pmem_wdata
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/control_module/state
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_control_module/state
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_datapath_module/lru/data
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_datapath_module/tag0/data
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_datapath_module/tag1/data
add wave -noupdate -height 15 -radix hexadecimal -childformat {{{/mp2_tb/dut/cache_datapath_module/data0/data[7]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data0/data[6]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data0/data[5]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data0/data[4]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data0/data[3]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data0/data[2]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data0/data[1]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data0/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp2_tb/dut/cache_datapath_module/data0/data[7]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data0/data[6]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data0/data[5]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data0/data[4]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data0/data[3]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data0/data[2]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data0/data[1]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data0/data[0]} {-height 15 -radix hexadecimal}} /mp2_tb/dut/cache_datapath_module/data0/data
add wave -noupdate -height 15 -radix hexadecimal -childformat {{{/mp2_tb/dut/cache_datapath_module/data1/data[7]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data1/data[6]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data1/data[5]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data1/data[4]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data1/data[3]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data1/data[2]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data1/data[1]} -radix hexadecimal} {{/mp2_tb/dut/cache_datapath_module/data1/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp2_tb/dut/cache_datapath_module/data1/data[7]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data1/data[6]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data1/data[5]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data1/data[4]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data1/data[3]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data1/data[2]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data1/data[1]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/cache_datapath_module/data1/data[0]} {-height 15 -radix hexadecimal}} /mp2_tb/dut/cache_datapath_module/data1/data
add wave -noupdate -height 15 -radix hexadecimal /mp2_tb/dut/cache_datapath_module/hit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2019212 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 338
configure wave -valuecolwidth 224
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
WaveRestoreZoom {1709283 ps} {2466397 ps}
