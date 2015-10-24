onerror {resume}
add list -hex -notrig -width 21 /mp3_tb/mem_address
add list -hex -notrig -width 4 /mp3_tb/mem_wdata
add list /mp3_tb/mem_write
add list -hex -notrig -width 4 /mp3_tb/dut/mem_address
add list -hex -notrig -width 4 /mp3_tb/dut/mem_wdata
add list /mp3_tb/dut/mem_write
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
