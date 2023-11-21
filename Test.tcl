# vcom -2008 *.vhd
# vsim MatrixRegister_tb
# add wave *
# run 20 ps

# vsim Accumulator_tb
# add wave -radix unsigned *
# run 20 ps

vsim Datapath_tb
add wave -radix unsigned *
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_MAT_A/o_Q
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_MAT_B/o_Q
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/wo_MULT
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_ACC/i_D
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_ACC/o_Q
add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_ACC/w_ACC
run 20 ps