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

## DATE    "Wed Nov  4 19:34:29 2015"

##
## DEVICE  "EP3SE50F780C2"
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
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_resp}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[12]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[13]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[14]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_address[15]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_read}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[12]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[13]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[14]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[15]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[16]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[17]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[18]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[19]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[20]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[21]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[22]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[23]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[24]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[25]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[26]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[27]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[28]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[29]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[30]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[31]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[32]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[33]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[34]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[35]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[36]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[37]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[38]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[39]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[40]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[41]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[42]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[43]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[44]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[45]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[46]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[47]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[48]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[49]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[50]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[51]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[52]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[53]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[54]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[55]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[56]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[57]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[58]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[59]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[60]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[61]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[62]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[63]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[64]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[65]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[66]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[67]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[68]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[69]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[70]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[71]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[72]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[73]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[74]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[75]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[76]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[77]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[78]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[79]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[80]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[81]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[82]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[83]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[84]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[85]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[86]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[87]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[88]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[89]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[90]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[91]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[92]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[93]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[94]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[95]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[96]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[97]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[98]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[99]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[100]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[101]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[102]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[103]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[104]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[105]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[106]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[107]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[108]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[109]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[110]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[111]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[112]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[113]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[114]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[115]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[116]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[117]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[118]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[119]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[120]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[121]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[122]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[123]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[124]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[125]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[126]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_wdata[127]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {pmem_write}]


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

