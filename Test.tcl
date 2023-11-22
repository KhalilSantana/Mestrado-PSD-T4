vcom -2008 *.vhd
# vsim MatrixRegister_tb
# add wave *
# run 100 ps

# vsim Accumulator_tb
# add wave -radix unsigned *
# run 20 ps

# vsim MatrixRegisterSingle_tb
# add wave *
# run 20 ps

vsim Datapath_tb
add wave -radix unsigned *
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_MAT_A/o_Q
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_MAT_B/o_Q
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_A0
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_A1
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_A2
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_B0
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_B1
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_B2
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_MULT_tmp_A0
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_MULT_tmp_A1
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_MULT_tmp_A2
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ADDERS_OUT
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_MAT_B/o_Q
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/wo_MULT
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_ACC/i_D
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_ACC/o_Q
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_ACC/w_ACC
run 20 ps