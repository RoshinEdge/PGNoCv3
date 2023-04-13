module MAIN_fpga1(
input  clk_50,
input  rst_n,
output led_clk,
input [16:0] data_FROM_fpga0,
input [16:0] data_FROM_fpga1,
input [16:0] data_FROM_fpga2,
input [16:0] data_FROM_fpga3,
input [16:0] data_FROM_fpga4,
input [16:0] data_FROM_fpga5,
input [16:0] data_FROM_fpga6,
input [16:0] data_FROM_fpga7,
input [16:0] data_FROM_fpga8,
input [16:0] data_FROM_fpga9,
output [16:0] data_TO_fpga0,
output [16:0] data_TO_fpga1,
output [16:0] data_TO_fpga2,
output [16:0] data_TO_fpga3,
output [16:0] data_TO_fpga4,
output [16:0] data_TO_fpga5,
output [16:0] data_TO_fpga6,
output [16:0] data_TO_fpga7,
output [16:0] data_TO_fpga8,
output [16:0] data_TO_fpga9,
output [6:0] segment_leds,
output [6:0] led_out
);

wire[16:0] r_minR   [0:8];
wire[16:0] r_maxR   [0:8];
wire[16:0] r_minL   [0:8];
wire[16:0] r_maxL   [0:8];
wire[16:0] in_free  [0:8];
wire[8:0]  out_data [0:8];
wire clk;

divider #(.POWER(24)) clk_div (.clk_in(clk_50), .clk_out(clk));

	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_0 (.clk(clk), .rst_n(rst_n), .inject(out_data[0]), .eject(in_free[0]));
	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_1 (.clk(clk), .rst_n(rst_n), .inject(out_data[1]), .eject(in_free[1]));
	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_2 (.clk(clk), .rst_n(rst_n), .inject(out_data[2]), .eject(in_free[2]));
	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_3 (.clk(clk), .rst_n(rst_n), .inject(out_data[3]), .eject(in_free[3]));
	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_4 (.clk(clk), .rst_n(rst_n), .inject(out_data[4]), .eject(in_free[4]));

 net_router r0( .clk(clk), .rst_n(rst_n), .router_name(4'b0),.in_free(in_free[0]), .in_r1R(r_minL[2]), .in_r2R(r_maxL[3]), .in_r1L(r_minR[7]), .in_r2L(r_maxR[6]), .out_r1R(r_minR[0]), .out_r2R(r_maxR[0]), .out_r1L(r_minL[0]), .out_r2L(r_maxL[0]), .out_data(out_data[0]) );
 net_router r1( .clk(clk), .rst_n(rst_n), .router_name(4'b1),.in_free(in_free[1]), .in_r1R(r_minL[3]), .in_r2R(r_maxL[4]), .in_r1L(r_minR[8]), .in_r2L(r_maxR[7]), .out_r1R(r_minR[1]), .out_r2R(r_maxR[1]), .out_r1L(r_minL[1]), .out_r2L(r_maxL[1]), .out_data(out_data[1]) );
 net_router r2( .clk(clk), .rst_n(rst_n), .router_name(4'b10),.in_free(in_free[2]), .in_r1R(r_minL[4]), .in_r2R(r_maxL[5]), .in_r1L(r_minR[0]), .in_r2L(r_maxR[8]), .out_r1R(r_minR[2]), .out_r2R(r_maxR[2]), .out_r1L(r_minL[2]), .out_r2L(r_maxL[2]), .out_data(out_data[2]) );
 net_router r3( .clk(clk), .rst_n(rst_n), .router_name(4'b11),.in_free(in_free[3]), .in_r1R(r_minL[5]), .in_r2R(r_maxL[6]), .in_r1L(r_minR[1]), .in_r2L(r_maxR[0]), .out_r1R(r_minR[3]), .out_r2R(r_maxR[3]), .out_r1L(r_minL[3]), .out_r2L(r_maxL[3]), .out_data(out_data[3]) );
 net_router r4( .clk(clk), .rst_n(rst_n), .router_name(4'b100),.in_free(in_free[4]), .in_r1R(r_minL[6]), .in_r2R(r_maxL[7]), .in_r1L(r_minR[2]), .in_r2L(r_maxR[1]), .out_r1R(r_minR[4]), .out_r2R(r_maxR[4]), .out_r1L(r_minL[4]), .out_r2L(r_maxL[4]), .out_data(out_data[4]) );

assign data_TO_fpga0 = r_minR[3];
assign data_TO_fpga1 = r_maxR[2];
assign data_TO_fpga2 = r_maxL[0];
assign data_TO_fpga3 = r_minR[4];
assign data_TO_fpga4 = r_maxR[3];
assign data_TO_fpga5 = r_minL[0];
assign data_TO_fpga6 = r_maxL[1];
assign data_TO_fpga7 = r_maxR[4];
assign data_TO_fpga8 = r_minL[1];
assign data_TO_fpga9 = r_maxL[2];
assign r_minR[7] = data_FROM_fpga0;
assign r_maxR[6] = data_FROM_fpga1;
assign r_minR[8] = data_FROM_fpga2;
assign r_maxR[7] = data_FROM_fpga3;
assign r_maxL[5] = data_FROM_fpga4;
assign r_maxR[8] = data_FROM_fpga5;
assign r_minL[5] = data_FROM_fpga6;
assign r_maxL[6] = data_FROM_fpga7;
assign r_minL[6] = data_FROM_fpga8;
assign r_maxL[7] = data_FROM_fpga9;

assign led_clk = ~clk;
endmodule