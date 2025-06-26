module QuadMUX_2to1(input [3:0] A,B, input Sel, output logic [3:0] W);

    assign W = (Sel == 1'b0) ? A:
                (Sel == 1'b1) ? B:
                    4'bx;
endmodule

module MUX2Bit_2to1(input [1:0] A,B, input Sel, output logic [1:0] W);

    assign W = (Sel == 1'b0) ? A:
                (Sel == 1'b1) ? B:
                    2'bx;
endmodule