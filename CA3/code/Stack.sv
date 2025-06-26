module Stack (clk, rst, push, pop, tos, d_in, d_out);
    input  clk;            
    input  rst;          
    input  push;           
    input  pop;   
    input logic [7:0] d_in;
    output logic [7:0] d_out;
    output logic [7:0] tos;            

    logic [7:0] stack_mem [0:255];
    logic [7:0] sp; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sp <= 0; 
        end else begin
            if (push && sp < 255) begin
                stack_mem[sp] <= d_in; 
                sp <= sp + 1;
            end
            if (pop && sp > 0) begin
                sp <= sp - 1; 
            end
        end
    end

    always_comb begin
        if (sp > 0) begin
            d_out = stack_mem[sp-1];
        end else if (pop && sp > 0) begin
            d_out = stack_mem[sp-1];
        end else begin
            d_out = 8'b0;
        end
    end

    assign tos = sp;

endmodule
