module Registor(pcnext,clk,rst,out);
    input [31:0] pcnext;
    input clk;
    input rst;
    output reg [31:0] out;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 32'b0;
        end 
        else begin
            out <= pcnext;
        end
    end
endmodule