module Register #(parameter LEN = 32) (in, clk, rst, out);
    input [LEN-1:0] in;
    input clk;
    input rst;
    output reg [LEN-1:0] out;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= {LEN{1'b0}};
        end 
        else begin
            out <= in;
        end
    end
endmodule

module EnRegister #(parameter LEN = 32) (in, en, clr, clk, rst, out);
    input [LEN-1:0] in;
    input clk;
    input rst;
    input en;
    input clr;
    output reg [LEN-1:0] out;
    
    always @(posedge clk or posedge rst) begin
        if (rst || clr) begin
            out <= {LEN{1'b0}};
        end
        else if(en)begin             
            out <= in;
        end
    end
endmodule