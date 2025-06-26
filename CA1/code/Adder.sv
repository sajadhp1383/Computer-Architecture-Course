module INC_2Bit(input [1:0] In, output [1:0] Out);
    assign  Out = In + 1;
endmodule

module INC_4Bit(input [3:0] In, output [3:0] Out);
    assign  Out = In + 1;
endmodule

module DEC_4Bit(input [3:0] In, output [3:0] Out);
    assign Out = In - 1;
endmodule