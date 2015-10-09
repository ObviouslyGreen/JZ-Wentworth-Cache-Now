onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 -label data0 /mp3_tb/dut/cache_datapath_module/data0/data
add wave -noupdate -height 15 -label tag0 /mp3_tb/dut/cache_datapath_module/tag0/data
add wave -noupdate -height 15 -label pc_out /mp3_tb/dut/datapath_module/pc_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24916137 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 128
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
WaveRestoreZoom {24877452 ps} {25164824 ps}
