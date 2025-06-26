module MAZE_MEM(input clk, RD, WR, Din, input [3:0] X,Y, input logic [0:15]  Memory [0:15], output logic Dout);

    always_comb begin
        if (RD)  
            Dout = Memory[X][Y];  
        else  
            Dout = 1'bz;
    end  

    always_ff @(posedge clk) begin
        if(WR)
            Memory[X][Y] <= Din;
        
    end

endmodule