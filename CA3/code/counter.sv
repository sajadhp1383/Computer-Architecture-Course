module Counter5Bit(clk, rst, en, ld, PI, count, co);
    input clk, rst, en, ld;
    input logic [4:0] PI;
    output logic [4:0] count;
    output logic co;

    always @(posedge clk or posedge rst) begin
        if(rst)
            count <= 5'b0;
        else if(ld)
            count <= PI;
        else
            {co, count} <= (en) ? count + 1 : count;
    end

endmodule