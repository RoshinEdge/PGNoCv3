module MAIN(
	input  clk_50, 
	input  rst_n,
	output led_clk,
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

	sm_cpu #(.ROM_FILE("send_wait_recieve.hex"))  cpu_0 (.clk(clk), .rst_n(rst_n), .inject(out_data[0]), .eject(in_free[0]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_1 (.clk(clk), .rst_n(rst_n), .inject(out_data[1]), .eject(in_free[1]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_2 (.clk(clk), .rst_n(rst_n), .inject(out_data[2]), .eject(in_free[2]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_3 (.clk(clk), .rst_n(rst_n), .inject(out_data[3]), .eject(in_free[3]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_4 (.clk(clk), .rst_n(rst_n), .inject(out_data[4]), .eject(in_free[4]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_5 (.clk(clk), .rst_n(rst_n), .inject(out_data[5]), .eject(in_free[5]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_6 (.clk(clk), .rst_n(rst_n), .inject(out_data[6]), .eject(in_free[6]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_7 (.clk(clk), .rst_n(rst_n), .inject(out_data[7]), .eject(in_free[7]));
	sm_cpu #(.ROM_FILE("send_wait_recieve.hex")) cpu_8 (.clk(clk), .rst_n(rst_n), .inject(out_data[8]), .eject(in_free[8]));
	
	net_router r1  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0000), .in_free(in_free[0]), .in_r1R(r_minL[2]), .in_r2R(r_maxL[3]), .in_r1L(r_minR[7]), .in_r2L(r_maxR[6]), .out_r1R(r_minR[0]), .out_r2R(r_maxR[0]), .out_r1L(r_minL[0]), .out_r2L(r_maxL[0]), .out_data(out_data[0]) );
	net_router r2  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0001), .in_free(in_free[1]), .in_r1R(r_minL[3]), .in_r2R(r_maxL[4]), .in_r1L(r_minR[8]), .in_r2L(r_maxR[7]), .out_r1R(r_minR[1]), .out_r2R(r_maxR[1]), .out_r1L(r_minL[1]), .out_r2L(r_maxL[1]), .out_data(out_data[1]) );
	net_router r3  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0010), .in_free(in_free[2]), .in_r1R(r_minL[4]), .in_r2R(r_maxL[5]), .in_r1L(r_minR[0]), .in_r2L(r_maxR[8]), .out_r1R(r_minR[2]), .out_r2R(r_maxR[2]), .out_r1L(r_minL[2]), .out_r2L(r_maxL[2]), .out_data(out_data[2]) );
	net_router r4  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0011), .in_free(in_free[3]), .in_r1R(r_minL[5]), .in_r2R(r_maxL[6]), .in_r1L(r_minR[1]), .in_r2L(r_maxR[0]), .out_r1R(r_minR[3]), .out_r2R(r_maxR[3]), .out_r1L(r_minL[3]), .out_r2L(r_maxL[3]), .out_data(out_data[3]) );
	net_router r5  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0100), .in_free(in_free[4]), .in_r1R(r_minL[6]), .in_r2R(r_maxL[7]), .in_r1L(r_minR[2]), .in_r2L(r_maxR[1]), .out_r1R(r_minR[4]), .out_r2R(r_maxR[4]), .out_r1L(r_minL[4]), .out_r2L(r_maxL[4]), .out_data(out_data[4]) );
	net_router r6  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0101), .in_free(in_free[5]), .in_r1R(r_minL[7]), .in_r2R(r_maxL[8]), .in_r1L(r_minR[3]), .in_r2L(r_maxR[2]), .out_r1R(r_minR[5]), .out_r2R(r_maxR[5]), .out_r1L(r_minL[5]), .out_r2L(r_maxL[5]), .out_data(out_data[5]) );
	net_router r7  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0110), .in_free(in_free[6]), .in_r1R(r_minL[8]), .in_r2R(r_maxL[0]), .in_r1L(r_minR[4]), .in_r2L(r_maxR[3]), .out_r1R(r_minR[6]), .out_r2R(r_maxR[6]), .out_r1L(r_minL[6]), .out_r2L(r_maxL[6]), .out_data(out_data[6]) );
	net_router r8  ( .clk(clk), .rst_n(rst_n), .router_name(4'b0111), .in_free(in_free[7]), .in_r1R(r_minL[0]), .in_r2R(r_maxL[1]), .in_r1L(r_minR[5]), .in_r2L(r_maxR[4]), .out_r1R(r_minR[7]), .out_r2R(r_maxR[7]), .out_r1L(r_minL[7]), .out_r2L(r_maxL[7]), .out_data(out_data[7]) );
	net_router r9  ( .clk(clk), .rst_n(rst_n), .router_name(4'b1000), .in_free(in_free[8]), .in_r1R(r_minL[1]), .in_r2R(r_maxL[2]), .in_r1L(r_minR[6]), .in_r2L(r_maxR[5]), .out_r1R(r_minR[8]), .out_r2R(r_maxR[8]), .out_r1L(r_minL[8]), .out_r2L(r_maxL[8]), .out_data(out_data[8]) );

	//seven_segment decoder (.din(out_data[0][3:0]), .enable(out_data[0][8]), .dout(segment_leds));
	seven_segment_mod decoder (.din(out_data[0][7:0]), .enable(out_data[0][8]), .dout(segment_leds));
	out_index oi1(	.data0(out_data[0][8:0]),
						.data1(out_data[1][8:0]),
						.data2(out_data[2][8:0]),
						.data3(out_data[3][8:0]),
						.data4(out_data[4][8:0]),
						.data5(out_data[5][8:0]),
						.data6(out_data[6][8:0]),
						.data7(out_data[7][8:0]),
						.data8(out_data[8][8:0]),.dout(led_out));

	assign led_clk = ~clk;
	
endmodule



