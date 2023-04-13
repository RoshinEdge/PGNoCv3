module MAIN_fpga2(
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

	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_5 (.clk(clk), .rst_n(rst_n), .inject(out_data[5]), .eject(in_free[5]));
	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_6 (.clk(clk), .rst_n(rst_n), .inject(out_data[6]), .eject(in_free[6]));
	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_7 (.clk(clk), .rst_n(rst_n), .inject(out_data[7]), .eject(in_free[7]));
	sm_cpu #(.ROM_FILE("C:\Users\RomashihinMU\Desktop\noc_verilog_mips_sources\true_source\send_wait_recieve.mem"))  cpu_8 (.clk(clk), .rst_n(rst_n), .inject(out_data[8]), .eject(in_free[8]));

 net_router r5( .clk(clk), .rst_n(rst_n), .router_name(4'b101),.in_free(in_free[5]), .in_r1R(r_minL[7]), .in_r2R(r_maxL[8]), .in_r1L(r_minR[3]), .in_r2L(r_maxR[2]), .out_r1R(r_minR[5]), .out_r2R(r_maxR[5]), .out_r1L(r_minL[5]), .out_r2L(r_maxL[5]), .out_data(out_data[5]) );
 net_router r6( .clk(clk), .rst_n(rst_n), .router_name(4'b110),.in_free(in_free[6]), .in_r1R(r_minL[8]), .in_r2R(r_maxL[0]), .in_r1L(r_minR[4]), .in_r2L(r_maxR[3]), .out_r1R(r_minR[6]), .out_r2R(r_maxR[6]), .out_r1L(r_minL[6]), .out_r2L(r_maxL[6]), .out_data(out_data[6]) );
 net_router r7( .clk(clk), .rst_n(rst_n), .router_name(4'b111),.in_free(in_free[7]), .in_r1R(r_minL[0]), .in_r2R(r_maxL[1]), .in_r1L(r_minR[5]), .in_r2L(r_maxR[4]), .out_r1R(r_minR[7]), .out_r2R(r_maxR[7]), .out_r1L(r_minL[7]), .out_r2L(r_maxL[7]), .out_data(out_data[7]) );
 net_router r8( .clk(clk), .rst_n(rst_n), .router_name(4'b1000),.in_free(in_free[8]), .in_r1R(r_minL[1]), .in_r2R(r_maxL[2]), .in_r1L(r_minR[6]), .in_r2L(r_maxR[5]), .out_r1R(r_minR[8]), .out_r2R(r_maxR[8]), .out_r1L(r_minL[8]), .out_r2L(r_maxL[8]), .out_data(out_data[8]) );

assign data_TO_fpga0 = r_minR[7];
assign data_TO_fpga1 = r_maxR[6];
assign data_TO_fpga2 = r_minR[8];
assign data_TO_fpga3 = r_maxR[7];
assign data_TO_fpga4 = r_maxL[5];
assign data_TO_fpga5 = r_maxR[8];
assign data_TO_fpga6 = r_minL[5];
assign data_TO_fpga7 = r_maxL[6];
assign data_TO_fpga8 = r_minL[6];
assign data_TO_fpga9 = r_maxL[7];
assign r_minR[3] = data_FROM_fpga0;
assign r_maxR[2] = data_FROM_fpga1;
assign r_maxL[0] = data_FROM_fpga2;
assign r_minR[4] = data_FROM_fpga3;
assign r_maxR[3] = data_FROM_fpga4;
assign r_minL[0] = data_FROM_fpga5;
assign r_maxL[1] = data_FROM_fpga6;
assign r_maxR[4] = data_FROM_fpga7;
assign r_minL[1] = data_FROM_fpga8;
assign r_maxL[2] = data_FROM_fpga9;

assign led_clk = ~clk;
endmodule