`timescale 1ns / 1ps

module mod_rx_commut#(
        parameter IN_WIDTH = 8,
        parameter OUT_WIDTH = 32
    )
(
    input clk,
    input start_sig,
    input [IN_WIDTH - 1:0] in_bus, 
    output reg [OUT_WIDTH - 1:0] out_bus,
    output reg ready = 0
);

parameter AR_SIZE = OUT_WIDTH / IN_WIDTH;
parameter NUMB_OF_SHIFTS = OUT_WIDTH / IN_WIDTH - 1;

reg [OUT_WIDTH - 1:0] shft_reg = 0;
reg [IN_WIDTH - 1:0] mem_reg = 0;

integer i = 0;
integer index = 0;
reg [IN_WIDTH - 1:0] mem_ar [0:AR_SIZE - 1];

reg [3:0] state = 0;
reg [7:0] len_of_bus = OUT_WIDTH >> NUMB_OF_SHIFTS;

                 always@(*)
                 for(i = 0;i < AR_SIZE; i = i + 1)
                        begin
                            shft_reg[i*IN_WIDTH +: IN_WIDTH] <= mem_ar[i];
                        end 

    always@(posedge clk)
    begin
        case(state)
        0: 
            begin
                if(start_sig)
                begin
                    out_bus <= shft_reg;        
                    state <= 1;
                    ready <= 0;
                end
                else state <= 0;
            end
        1:
            begin
                if(len_of_bus != 0)
                begin
                    mem_ar[index] <= in_bus;
                    len_of_bus <= len_of_bus>> 1;
                    index <= index + 1;
                end
                else 
                    begin 
                        mem_ar[index] <= in_bus;
                        state <= 0;
                        ready <= 1;
                        index <= 0;
                        len_of_bus <= OUT_WIDTH >> NUMB_OF_SHIFTS;
                    end
            end
        
        endcase
        
    end


endmodule
