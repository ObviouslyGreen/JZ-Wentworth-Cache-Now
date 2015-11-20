## Generated SDC file "mp3.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.1.4 Build 182 03/12/2014 SJ Full Version"

## DATE    "Thu Nov 19 21:20:50 2015"

##
## DEVICE  "EP3SE80F1152C2"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 10.000 -waveform { 0.000 5.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {clk}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[3]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[4]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[5]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[6]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[7]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[8]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[9]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[10]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[11]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[12]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[13]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[14]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[15]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[16]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[17]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[18]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[19]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[20]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[21]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[22]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[23]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[24]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[25]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[26]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[27]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[28]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[29]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[30]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[31]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[32]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[33]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[34]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[35]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[36]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[37]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[38]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[39]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[40]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[41]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[42]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[43]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[44]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[45]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[46]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[47]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[48]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[49]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[50]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[51]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[52]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[53]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[54]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[55]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[56]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[57]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[58]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[59]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[60]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[61]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[62]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[63]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[64]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[65]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[66]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[67]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[68]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[69]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[70]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[71]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[72]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[73]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[74]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[75]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[76]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[77]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[78]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[79]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[80]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[81]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[82]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[83]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[84]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[85]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[86]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[87]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[88]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[89]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[90]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[91]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[92]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[93]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[94]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[95]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[96]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[97]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[98]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[99]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[100]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[101]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[102]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[103]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[104]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[105]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[106]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[107]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[108]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[109]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[110]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[111]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[112]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[113]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[114]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[115]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[116]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[117]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[118]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[119]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[120]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[121]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[122]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[123]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[124]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[125]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[126]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[127]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[128]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[129]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[130]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[131]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[132]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[133]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[134]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[135]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[136]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[137]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[138]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[139]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[140]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[141]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[142]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[143]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[144]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[145]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[146]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[147]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[148]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[149]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[150]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[151]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[152]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[153]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[154]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[155]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[156]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[157]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[158]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[159]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[160]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[161]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[162]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[163]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[164]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[165]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[166]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[167]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[168]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[169]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[170]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[171]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[172]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[173]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[174]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[175]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[176]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[177]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[178]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[179]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[180]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[181]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[182]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[183]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[184]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[185]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[186]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[187]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[188]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[189]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[190]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[191]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[192]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[193]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[194]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[195]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[196]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[197]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[198]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[199]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[200]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[201]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[202]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[203]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[204]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[205]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[206]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[207]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[208]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[209]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[210]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[211]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[212]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[213]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[214]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[215]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[216]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[217]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[218]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[219]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[220]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[221]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[222]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[223]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[224]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[225]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[226]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[227]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[228]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[229]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[230]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[231]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[232]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[233]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[234]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[235]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[236]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[237]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[238]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[239]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[240]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[241]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[242]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[243]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[244]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[245]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[246]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[247]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[248]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[249]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[250]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[251]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[252]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[253]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[254]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_rdata[255]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_resp}]


#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

