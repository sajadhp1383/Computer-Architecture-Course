module INC(input [3:0] In, output [3:0] Out);
    assign  Out = In + 1;
endmodule

module DEC(input [3:0] In, output [3:0] Out);
    assign Out = In - 1;
endmodule