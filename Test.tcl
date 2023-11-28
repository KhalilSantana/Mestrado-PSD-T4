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

# vsim Datapath_tb
# add wave -radix unsigned *
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_MAT_A/o_Q
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/u_MAT_B/o_Q
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_A0
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_A1
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_A2
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_B0
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_B1
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ELE_B2
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_MULT_tmp_A0
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_MULT_tmp_A1
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_MULT_tmp_A2
# add wave -radix unsigned -position end  sim:/datapath_tb/u_Datapath/w_ADDERS_OUT
# run 20 ps
vsim Toplevel_tb
add wave *
add wave -position end  sim:/toplevel_tb/u_Toplevel/u_Controller/w_NEXT
add wave -position end  sim:/toplevel_tb/u_Toplevel/u_Controller/r_STATE
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Controller/o_MAT_A_ADDR_ROW
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Controller/o_MAT_B_ADDR_ROW
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Controller/o_MAT_C_ADDR_COL
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_ELE_A0
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_ELE_A1
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_ELE_A2
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_ELE_B0
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_ELE_B1
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_ELE_B2
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_MULT_tmp_A0
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_MULT_tmp_A1
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_MULT_tmp_A2
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_MULT_A0
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_MULT_A1
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_MULT_A2
add wave -radix unsigned -position end  sim:/toplevel_tb/u_Toplevel/u_Datapath/w_ADDERS_OUT
run 100 ps