module QuadMUX_2to1(input [3:0] A,B, input Sel, output logic [3:0] W);

    assign W = (Sel == 1'b0) ? A:
                (Sel == 1'b1) ? B:
                    4bx;
endmodule