module Register(clk, rst, PI, ld, out);

    input clk,rst,ld;
    input [7:0] PI;
    output logic [7:0] out;
    
    always@(posedge clk, posedge rst) begin
        if (rst)
            out <= 7'b0;
        else if(ld)
            out <= PI;
        else
            out <= out;
        
    end

endmodule