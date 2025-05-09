module Adder(a,b,w);
    input [31:0] a,b;
    output wire [31:0] w;

    assign w = a + b;
    
endmodule