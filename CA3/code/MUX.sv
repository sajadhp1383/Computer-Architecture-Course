module MUX2to1_8Bit(input [7:0] i0 , i1, input sel, output [7:0] out);
    assign out = sel ? i1 : i0;
endmodule


module MUX2to1_5Bit(input [4:0] i0 , i1, input sel, output [4:0] out);
    assign out = sel ? i1 : i0;
endmodule