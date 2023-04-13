`timescale 1ns / 1ps

module clock_control
#(
        parameter IN_WIDTH = 8,
        parameter OUT_WIDTH = 32
    )
    (
    input clk,
    input data_trans_ready,
    
    output reg MIPS_CLK = 0,
    output reg begin_trans = 0
    );
    
    reg [31:0] timer = 0;
    reg no_stop = 1;
    reg parity = 0;
    
    reg [3:0] state = 0;
    
    
    always@(posedge clk)
    begin
    
        if(no_stop)
        begin
            if( ((IN_WIDTH / OUT_WIDTH)+1) >= timer) timer <= timer + 1;
            else
            begin
                timer <= 0;
                MIPS_CLK <= ~MIPS_CLK;
                parity = ~parity;
            end
        end
    
        case(state)
        0:
            begin
                if(~parity)
                begin
                    no_stop <= 0;
                    begin_trans <= 1;
                    state <= 1;
                end
            end
        1:
            begin
                if(data_trans_ready)
                    begin
                        no_stop <= 1;
                        state <= 0;
                    end
            end
        endcase
    
    end
    
endmodule
