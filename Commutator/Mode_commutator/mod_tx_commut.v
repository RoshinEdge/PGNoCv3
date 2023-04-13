`timescale 1ns / 1ps

module mod_tx_commut
    #(
        parameter IN_WIDTH = 32,
        parameter OUT_WIDTH = 8,
        parameter NUMB_OF_SHIFTS = IN_WIDTH / OUT_WIDTH - 1
    )
(
    input clk,
    input start_sig,
    input [IN_WIDTH - 1:0] in_bus, 
    
    output [OUT_WIDTH - 1:0] out_bus,
    output reg ready = 0
);

reg [IN_WIDTH - 1:0] shft_reg;
reg [3:0] state = 0;
reg [7:0] len_of_bus = IN_WIDTH >> NUMB_OF_SHIFTS;

assign out_bus = shft_reg[OUT_WIDTH - 1:0];


    always@(posedge clk)
    begin
        case(state)
        0: 
            begin
                //if(start_sig)
                begin
                    len_of_bus <= IN_WIDTH >> NUMB_OF_SHIFTS;
                    shft_reg <= in_bus;
                    state <= 1;
                    ready <= 0;
                end
                //else state <= 0;
            end
        1:
            begin
                if(len_of_bus != 0)
                begin
                    shft_reg <= shft_reg >> OUT_WIDTH;
                    len_of_bus <= len_of_bus>> 1;
                end
                else 
                    begin  
                        state <= 0;
                        ready <= 1;
                    end
            end
        
        endcase
        
    end

endmodule

